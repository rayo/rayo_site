%w(rubygems awesome_print sinatra).each{|lib| require lib}

configure do
	set :views, "#{File.dirname(__FILE__)}/views"
end


helpers do
	# add your helpers here
end

# root page
get '/' do
  erb :coming_soon,{:layout => :special}
end

get '/about' do 
  @title = "Rayo Messaging Protocol"
  @page = "about"
  erb :about 
end
# spec page
get '/spec' do
	@title = "Rayo Messaging Protocol Specification"
	@page = "spec"
	erb :spec
end

# who's using it page
get '/who' do
	@title = "Rayo Messaging Protocol - Who's using it"
	@page = "who"
	erb :who
end

get '/xep' do
  redirect 'http://ci.mojolingo.com/job/Rayo%20Spec/lastSuccessfulBuild/artifact/extensions/rayo.html'
end
