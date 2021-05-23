module Ingestion
  module_function

  def ingest_record(id)
    MDL::TransformWorker.new.perform(
      [id.split(':')],
      { url: config[:solr_config][:url] },
      config[:cdm_endpoint],
      config[:oai_endpoint],
      config[:field_mappings],
      false
    )
    SolrClient.new.commit
  end

  def etl
    @etl ||= MDL::ETL.new
  end

  def config
    @config ||= etl.config
  end
end
