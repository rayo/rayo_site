%w(rubygems awesome_print sinatra).each { |lib| require lib }

get '/' do
  @title = "Rayo 3PCC Protocol"
  @page = "about"
  erb :about
end

get '/about' do
  @title = "Rayo 3PCC Protocol"
  @page = "about"
  erb :about
end

get '/spec' do
  @title = "Rayo 3PCC Protocol Specification"
  @page = "spec"
  erb :spec
end

get '/participate' do
  @title = "Rayo 3PCC Protocol - Participate"
  @page = "participate"
  erb :participate
end

get '/who' do
  @title = "Rayo 3PCC Protocol - Who's using it"
  @page = "who"
  erb :who
end

get '/xep' do
  redirect 'http://xmpp.org/extensions/xep-0327.html'
end
