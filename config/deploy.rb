require "bundler/capistrano"

set :application, "for30days"
set :repository,  "git@github.com:nitsujri/for30days.git"

role :app, "54.214.160.76"
role :web, "54.214.160.76"
role :db, "54.214.160.76", :primary => true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "ubuntu"
set :use_sudo, false
set :deploy_via, :remote_cache
set :keep_releases, 5

set :deploy_to, "/data/#{application}"

set :bundle_flags, "--deployment --quiet --binstubs"

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

# answer = Capistrano::CLI.ui.ask "Are you sure you want to deploy *PRODUCTION*? [yes/NO]: "
# unless answer == 'yes'
#   raise CommandError.new("Decided NOT to deploy to Production.")
# end

before 'deploy:update_code', "deploy:add_host_keys"
before 'deploy:assets:precompile', 'deploy:cp_database_yml'
after 'deploy:update_code', 'deploy:cleanup'

namespace :deploy do
  task :add_host_keys do
    run "sudo bash -c 'ssh-keyscan -t rsa github.com > /etc/ssh/ssh_known_hosts'"
  end

  desc "Replacing the database.yml"
  task :cp_database_yml do
    old_path = File.join(release_path, "config", "database.yml.production")
    new_path = File.join(release_path, "config", "database.yml")
    run "cp #{old_path} #{new_path}"
  end
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end