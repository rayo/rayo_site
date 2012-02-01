# My pimped out unicorn config, with incremental killof
# and all the latest capistrano & bundler-proofing
# @jamiew :: http://github.com/jamiew

application = "www.rayo.org"
environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'
app_path = "/srv/www/#{application}"
bundle_path = "#{app_path}/shared/bundle"

timeout 30
preload_app true
worker_processes 4

# Listen on both fast-failing unix data socket & a backloggable TCP connection
listen "#{app_path}/shared/tmp/sockets/unicorn.sock", :backlog => 64

# Hard-set the CWD & pidfile to ensure app-reloading consistency
working_directory "#{app_path}/current"
stderr_path "#{app_path}/shared/logs/unicorn.stderr.log"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"

# Helps ensure the correct unicorn binary is used when upgrading with USR2
# See http://unicorn.bogomips.org/Sandbox.html
Unicorn::HttpServer::START_CTX[0] = "#{bundle_path}/bin/unicorn"

# REE-friendly
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

# Rails breaks unicorn's logger formatting, reset it
# http://rubyforge.org/pipermail/mongrel-unicorn/2010-October/000732.html
Unicorn::Configurator::DEFAULTS[:logger].formatter = Logger::Formatter.new

# Forcibly clean environment variables between bundlings
# http://www.mail-archive.com/mongrel-unicorn@rubyforge.org/msg00276.html
before_exec do |_|
  paths = (ENV["PATH"] || "").split(File::PATH_SEPARATOR)
  paths.unshift "#{bundle_path}/bin"

  ENV["PATH"] = paths.uniq.join(File::PATH_SEPARATOR)
  ENV["GEM_HOME"] = ENV['GEM_PATH'] = bundle_path
  ENV["BUNDLE_GEMFILE"] = "/srv/#{application}/current/Gemfile"
end


before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)

  # Incremental kill-off
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      puts "Sending #{sig} signal to old unicorn master..."
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly (for incremental kill-off only)
  sleep 1
end

after_fork do |server, worker|
  #NewRelic::Agent.shutdown
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end


