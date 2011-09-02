$LOAD_PATH << '.'

require 'application.rb'

set :run, true
set :environment, :production

FileUtils.mkdir_p 'logs' unless File.exists?('logs')
log = File.new("logs/sinatra.log", "a+")
$stdout.reopen(logs)
$stderr.reopen(logs)

use Rack::ShowExceptions

run Sinatra::Application