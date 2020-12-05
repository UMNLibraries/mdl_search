require 'cdmbl'
require 'mdl/transformer'

module MDL
  ###
  # This FieldTransformer subclass exists to aggregate fields of
  # "child" compounds to an indexed, multivalued field on the parent
  # so that searches for content that exists in child documents return
  # results that contain the parent document.
  class CompoundAggregatingFieldTransformer < CDMBL::FieldTransformer
    TRANSC_FIELD_MAPPING = MDL::Transformer.field_mappings.find do |m|
      m[:dest_path] == 'transcription_tesi'
    end.transform_values(&:dup) # Dup the values so we don't have frozen strings

    attr_reader :record

    def initialize(record:, **args)
      @record = record
      super
    end

    def reduce
      super.tap do |hsh|
        hsh.merge!(aggregations)
      end
    end

    private

    def aggregations
      {}.tap do |hsh|
        hsh.merge!(transcriptions)
      end.select { |_, v| v.present? }
    end

    def transcriptions
      transcription_pages = Array(record['page']).select { |p| p['transc'] }
      transcriptions = transcription_pages.flat_map do |page|
        transc_transformer = self.class.superclass.new(
          record: page,
          field_mapping: CDMBL::FieldMapping.new(config: TRANSC_FIELD_MAPPING)
        ).reduce.values
      end
      { 'transcription_tesim' => transcriptions }
    end
  end

  class RecordTransformer < CDMBL::RecordTransformer
    def field_transformer
      CompoundAggregatingFieldTransformer
    end
  end

  class CompoundAggregatingTransformer < CDMBL::Transformer
    def record_transformer
      RecordTransformer
    end
  end

  class TransformWorker < CDMBL::TransformWorker
    def transformer_klass
      @transformer_klass ||= CompoundAggregatingTransformer
    end
  end

  class ETLWorker < CDMBL::ETLWorker
    def transform_worker_klass
      @transform_worker_klass ||= TransformWorker
    end

    def etl_worker_klass
      @etl_worker_klass ||= self.class
    end
  end
end
