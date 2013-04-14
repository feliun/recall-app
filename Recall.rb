#Understands Recall web application requests

require 'sinatra' 
require 'yaml'
require_relative './Note'
require_relative './RedisManager'

#TODO: change to global and check they are created only once

$config = YAML.load_file("./config/config.yaml") unless $config
$redisManager = RedisManager.new unless $redisManager

get '/' do  
	@notes = $redisManager.getAllNotes
	@title = $config["web_title"] 
	erb :home  
end  

post '/' do
  	$redisManager.save(Note.new(params[:content], false, Time.now, Time.now))
	redirect '/'  
end  