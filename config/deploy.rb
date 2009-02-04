set :runner, "scottmotte"
set :use_sudo, false

# =============================================================================
# CUSTOM OPTIONS
# =============================================================================
set :user, "scottmotte"
set :application, "jmading-old.com"
set :domain, "jmading.com"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

# =============================================================================
# DATABASE OPTIONS
# =============================================================================
# set :migrate_env, "MERB_ENV=production"

# =============================================================================
# DEPLOY TO
# =============================================================================
set :deploy_to, "/home/#{user}/apps/#{application}"

# # =============================================================================
# # REPOSITORY
# # =============================================================================
set :repository,  "ssh://scottmotte@hermes.thruhere.net:1986/home/scottmotte/git/#{application}.git"
set :scm, "git"
set :branch, "master"

# =============================================================================
# SSH OPTIONS
# =============================================================================
default_run_options[:pty] = true
ssh_options[:paranoid] = false
ssh_options[:keys] = %w(/Users/scottmotte/.ssh/id_rsa)
ssh_options[:port] = 1985


# =============================================================================
# RAKE TASKS & OTHER SERVER TASKS
# =============================================================================
desc "Create symlink to public_html/jmading-old.com/public"
task :symlinkify do
  run "rm -rf /home/#{user}/public_html/jmading.com/public; ln -s #{current_path}/public /home/#{user}/public_html/jmading.com"
end

namespace :deploy do
  # override Rails related callbacks
  task :finalize_update do
  end
 
  task :migrate do
  end
  
  desc 'restart app'
  task :restart do
    # sudo '/etc/init.d/apache2 restart'
  end
end

after 'deploy:update_code', "symlinkify"