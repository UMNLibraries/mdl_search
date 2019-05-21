server "192.168.33.15", user: "swadm", roles: %w{app db web}
set :deploy_to, "/swadm/var/www/app"
set :use_sudo, false
set :rails_env, "production"
set :bundle_flags, '--deployment'
set :keep_releases, 2
set :branch, 'updates'