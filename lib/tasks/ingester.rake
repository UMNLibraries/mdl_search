namespace :mdl_ingester do

  desc 'Extract OAI results to the local file system.'
  task :extract do
    oai_endpoint = 'http://cdm16022.contentdm.oclc.org/oai/oai.php'
    CDMBL::OAIWorker.perform_async(oai_endpoint, false, File.join(Rails.root, 'oai_records'))
  end

  desc "ingest batches of records"
  ##
  # e.g. rake mdl_ingester:ingest[10, 2]
  task :batch, [:batch_size, :set_spec] => :environment  do |t, args|
    config  =
      {
        oai_endpoint: 'http://cdm16022.contentdm.oclc.org/oai/oai.php',
        cdm_endpoint: 'https://server16022.contentdm.oclc.org/dmwebservices/index.php',
        set_spec: (args[:set_spec] != '""') ? args[:set_spec] : nil,
        max_compounds: 1,
        batch_size: 5,
        solr_config: solr_config
      }
    CDMBL::ETLWorker.perform_async(config)
  end

  desc "delete batches of unpublished records"
  ##
  # e.g. rake mdl_ingester:delete
  task :delete do
    CDMBL::BatchDeleterWorker.perform_async(
      0,
      'oai:cdm16022.contentdm.oclc.org:',
      'http://cdm16022.contentdm.oclc.org/oai/oai.php',
      solr_config[:url]
    )
  end

  def solr_config
    { url: "#{base_url}:8983/solr/mdl-1" }
  end

  def base_url
    (ENV['RAILS_ENV'] == 'production') ? 'http://localhost' : 'http://solr'
  end
end
