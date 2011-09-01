$LOAD_PATH << '.'

require 'application.rb'

set :run, true
set :environment, :production

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)



use Rack::ShowExceptions

run Sinatra::Application

