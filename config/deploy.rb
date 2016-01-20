# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'messagefollowerlive'
set :repo_url, 'git@github.com:tkaboris/messagefollowerlive.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/rails/app/messagefollowerlive'

# Default tmp_dir directory is /var/www/tmp
set :tmp_dir, "/home/rails/app/messagefollowerlive/shared/tmp"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, fetch(:linked_files, []).push('config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :default_env, {
  PATH: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
  RBENV_ROOT: '~/.rbenv',
  RBENV_VERSION: File.read('.ruby-version').strip
}

set :sidekiq_role, :app
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
set :sidekiq_env, 'production'


set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :whenever_roles,        ->{ :app }
set :whenever_options,      ->{ {:roles => fetch(:whenever_roles)} }
set :whenever_environment,  ->{ fetch :rails_env, "production" }
set :whenever_variables,    ->{ "environment=#{fetch :whenever_environment}" }
set :whenever_update_flags, ->{ "--update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}" }
set :whenever_clear_flags,  ->{ "--clear-crontab #{fetch :whenever_identifier}" }

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end
end
