require 'bundler'
Bundler.require

require File.join(File.dirname(__FILE__), 'application')

set :run, true
set :environment, :production

FileUtils.mkdir_p 'logs' unless File.exists?('logs')
logs = File.new("logs/sinatra.log", "a+")
$stdout.reopen(logs)
$stderr.reopen(logs)

use Rack::ShowExceptions

run Sinatra::Application
