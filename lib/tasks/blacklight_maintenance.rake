namespace :blacklight_maintenance do
  # Search sessionsn build-up over time. This task should be fired periodically
  # from a cron job
  desc "truncate search table"
  task :truncate_searches => :environment do
    ActiveRecord::Base.connection.execute("truncate searches")
  end
end
