require "#{Rails.root}/lib/sunrise/lib/sunrise"

namespace :solr do
  include Sunrise::SetupHelper

  desc "download solr cores for projection"
  task :setup_prod do
  	SolrCore.new(name: 'mdl', dir: '../shared/cores', repo: 'mdl-solr-core', org: 'UMNLibraries', version: 'master').run! end

  desc "download solr cores for test"
  task :setup_test do
  	SolrCore.new(name: 'mdl', repo: 'mdl-solr-core', org: 'UMNLibraries', version: 'master', example_data_uri: 'https://s3.amazonaws.com/mdl.indexes/latest-data.tar.gz').run!
  end

  desc "download solr cores for development"
  task :setup_dev do
  	SolrCore.new(dir: '/mdl_search/cores', name: 'mdl', repo: 'mdl-solr-core', org: 'UMNLibraries', version: 'master', example_data_uri: 'https://s3.amazonaws.com/mdl.indexes/latest-data.tar.gz').run!
  end

  desc "commit changes"
  task commit: [:environment]  do
  	SolrClient.new.client.commit
  end

  desc "optimize core"
  task optimize: [:environment]  do
  	SolrClient.new.client.optimize
  end

  desc "delete core index"
  task delete_index: [:environment]  do
  	SolrClient.new.delete_index
  end
end
