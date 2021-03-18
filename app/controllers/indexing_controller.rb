class IndexingController < ApplicationController
  before_action :authenticate_user!

  FACET_FIELD = 'oai_set_ssi'.freeze

  include Blacklight::Catalog

  blacklight_config.configure do |config|
    config.add_facet_field FACET_FIELD do |field|
      field.index_range = 'A'..'Z'
      field.limit = -1 # Blacklight's default is 100, but we do not want to limit
    end
  end

  def index
    @collections = collections
  end

  def create
    MDL::ETLWorker.perform_async(etl_config)
    redirect_to indexing_path, flash: { notice: 'Queued collection for indexing' }
  end

  private

  def collections
    facet = blacklight_config.facet_fields[FACET_FIELD]
    response = get_facet_field_response(facet.key, {})
    response.aggregations[facet.key].items.map do |item|
      set_spec, collection_name, _ = item.value.split(MDL::OaiSetFormatter.delimiter)
      [collection_name, set_spec]
    end.sort_by(&:first)
  end

  def etl_config
    MDL::ETL.new.config.merge(
      set_spec: params.require(:collection),
      from: Date.parse(params.require(:date)).iso8601
    )
  end
end
