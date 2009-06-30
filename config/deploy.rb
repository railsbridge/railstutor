set :application, "railstutor"
set :repository,  "git://github.com/railsbridge/railstutor.git"
set :user, "webadmin"
set :deploy_via, :copy
set :scm, :git

# Will checkout a copy locally from :repository and upload as a tar.gz file
set :deploy_via, :copy
set :git_shallow_clone, 1 

set :branch, "master"
set :user, "rbadmin"
set :use_sudo, true
set :keep_releases, 3

role :app, "72.249.191.152"
role :web, "72.249.191.152"
role :db,  "72.249.191.152", :primary => true

task :after_update_code do
end

set :keep_releases, 3
# after "deploy:update", "deploy:cleanup"

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :localize do
  desc "copy shared configurations to current"
  task :copy_shared_configurations, :roles => [:app] do
    %w[database.yml email.yml].each do |f|
      run "ln -nsf #{shared_path}/config/#{f} #{current_path}/config/#{f}"
    end

    run "ln -nsf #{shared_path}/config/session_store.rb #{current_path}/config/initializers/session_store.rb"
  end

  desc "link shared file storage to current"
  task :link_shared_file_storage, :roles => [:app] do
    run "ln -nsf #{shared_path}/files #{current_path}/files"
  end

end

after "deploy:symlink", "localize:copy_shared_configurations", "localize:link_shared_file_storage", "deploy:cleanup"
