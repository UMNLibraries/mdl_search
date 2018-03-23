set :ssh_options, keys:  ['/home/fenne035/dev/vms/mdl/ansible-playbook-blacklight/.vagrant/machines/blacklight/virtualbox/private_key']
server '127.0.0.1:2222', user: 'swadm', roles: %w{web app db}
set :ssh_options, {:forward_agent => true, :keys =>  ['/home/fenne035/dev/vms/mdl/ansible-playbook-blacklight/.vagrant/machines/blacklight/virtualbox/private_key']}

set :deploy_to, '/swadm/var/www/blacklight'
set :use_sudo, false

set :linked_dirs, %w(thumbnails log public/assets tmp/pids tmp/sockets)

set :rails_env, "production"

set :bundle_flags, '--deployment'

set :sidekiq_concurrency, 1
set :sidekiq_processes, 2

set :branch, 'feature/ansible-v-2'

set :passenger_restart_with_touch, true