set :domain, "swadm@mtx-reflectqa-qat.oit.umn.edu"

role :app, "swadm@mtx-reflectqa-qat.oit.umn.edu"
role :web, "swadm@mtx-reflectqa-qat.oit.umn.edu"
role :db, "swadm@mtx-reflectqa-qat.oit.umn.edu", primary: true

set :ssh_options, {:forward_agent => true}

set :deploy_to, '/swadm/var/www/mtx-reflectqa-qat.oit.umn.edu'
set :use_sudo, false

append :linked_dirs, "log"

set :rails_env, "production"

set :bundle_flags, '--deployment'

set :sidekiq_concurrency, 2
set :sidekiq_processes, 2

set :keep_releases, 2
set :passenger_restart_with_touch, true

set :branch, 'develop'