#Understands Recall web application requests

require 'sinatra' 
require 'yaml'
require_relative './Note'
require_relative './RedisManager'

#TODO: how to avoid the creation of this instances every time?

get '/' do  
	@config = YAML.load_file("./config/config.yaml")
	@redisManager = RedisManager.new
	@notes = @redisManager.getAllNotes
	@title = @config["web_title"] 
	erb :home  
end  

post '/' do  
	note = Note.new(params[:content], false, Time.now, Time.now)
	@redisManager = RedisManager.new
  	@redisManager.save(note)
	redirect '/'  
end  