require "#{Rails.root}/lib/sunrise/lib/sunrise"

namespace :solr do
  include Sunrise::SetupHelper

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

  desc "backup core index"
  task backup: [:environment]  do
  	SolrClient.new.backup
  end

  desc "backup core index"
  task restore: [:environment]  do
  	SolrClient.new.restore
  end
end
