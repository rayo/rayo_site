%w(rubygems awesome_print sinatra).each{|lib| require lib}

configure do
	set :views, "#{File.dirname(__FILE__)}/views"
end


helpers do
	# add your helpers here
end

# root page
get '/' do
	@title = "Rayo Messaging Protocol"
	@page = "about"
	erb :about
end
