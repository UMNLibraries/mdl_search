namespace :mdl_ingester do

  desc 'Extract OAI results to the local file system.'
  task :extract do
    oai_endpoint = 'http://cdm16022.contentdm.oclc.org/oai/oai.php'
    CDMBL::OAIWorker.perform_async(oai_endpoint, false, File.join(Rails.root, 'oai_records'))
  end

  desc "ingest batches of records"
  ##
  # e.g. rake mdl_ingester:ingest[10, 2]
  task :batch, [:set_spec] => :environment  do |t, args|
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

  desc 'Index MDL Content base on setSpec pattern matching'
  task :by_collections, [:pattern, :inclusive, :batch_size] => :environment  do |t, args|
    #TODO: encapsulate some of this logic in a CDMBL class
    pattern    = args.fetch(:pattern, false)
    inclusive  = args.fetch(:inclusive, true)
    oai_endpoint = 'http://cdm16022.contentdm.oclc.org/oai/oai.php'
    class DefaultFilterCallback
      def valid?(set: {})
        true
      end
    end
    set_specs =
      if pattern
        filter = CDMBL::SetSpecFilterCallback.new(pattern: Regexp.new(pattern))
        CDMBL::FilteredSetSpecs.new(oai_base_url: oai_endpoint,
                                    callback: filter).set_specs
      else
        CDMBL::FilteredSetSpecs.new(oai_base_url: oai_endpoint,
                                    callback: DefaultFilterCallback.new).set_specs
      end
    puts "Indexing Sets: '#{set_specs.join(', ')}'"
    etl_config  = {
      oai_endpoint: oai_endpoint,
      cdm_endpoint: 'https://server16022.contentdm.oclc.org/dmwebservices/index.php',
      max_compounds: 1,
      batch_size: args.fetch(:batch_size, 5),
      solr_config: solr_config
    }
    CDMBL::ETLBySetSpecs.new(set_specs: set_specs, etl_config: etl_config).run!
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
