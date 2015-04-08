lock '3.4.0'
set :rbenv_ruby, '2.1.2'
# set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :application, 'learningapp'
# set :repo_url, 'git@github.com:mohan589/learnviaonline.git'
set :repo_url, '/media/mohan/softwares/LearingApp/LearingApp/.git'
# set :passenger_restart_with_sudo, true
# set :passenger_restart_command, 'passenger-config restart-app'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/mohan/learnviaonline'
set :stages, ["staging", "development", "production"]
set :default_stage, "production"
# Default value for :scm is :git
# set :ssh_options, {:forward_agent => true}
set :scm, :git
set :branch, "master"
set :user, "mohan"
set :rails_env, "production"
# set :rails_env, "staging"
set :deploy_via, :copy
set :use_sudo, true
set :releases_path, File.join(deploy_to)
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :chown, "-R :#{fetch(:group)} #{deploy_to} && chmod -R g+s #{deploy_to}"
    end
  end

  # desc 'Runs rake db:migrate if migrations are set'
  # task :migrate do
    # on primary fetch(:migration_role) do
      # puts "From migrate task -> Release path is: #{release_path.to_s}" 
      # within release_path do
        # with rails_env: fetch(:rails_env) do
        # execute 'cd #{releases_path}'
        # execute :rake, "db:migrate RAILS_ENV=production"
        # end
      # end
    # end
  # end

  desc "Transfer Figaro's application.yml to shared/config"
  task :migrate do
    on roles(:all), in: :sequence, wait: 5 do
      execute 'cd #{deploy_to}/current'      
      execute 'cd #{deploy_to}/current && bundle install --path vendor/cache'
      execute 'cd #{deploy_to}/current && bundle exec rake assets:precompile'
      execute 'cd #{deploy_to}/current && bundle exec rake db:migrate RAILS_ENV = production'      
    end
  end

  after :publishing, :restart
  

  namespace :dbsetup do
    desc "run bundle_install"
    task :bundleinstall do
      on roles(:all) do
        run 'mv database.yml #{deploy_to}/current/config'
        run "cd '#{deploy_to}'/current/"
        run "bundle install"
      end
    end
  end

  namespace :figaro do      
   desc "Transfer Figaro's application.yml to shared/config"
   task :upload do
     on roles(:all) do
       upload! "config/database.yml", "#{shared_path}/config/database.yml"
     end
   end
 end

 after 'deploy:updated', 'deploy:migrate'
 before "deploy:check", "figaro:upload"
 # after "deploy:finished", "dbsetup:bundleinstall"
 

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'      
      # end
    end
  end

# set :rvm_ruby_version, '1.9.3'
# set :default_env, { rvm_bin_path: '~/.rbenv/bin' }
# SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rbenv_bin_path]}/rvm ruby-#{fetch(:rbenv_ruby_version)} do bundle exec rake"
end
