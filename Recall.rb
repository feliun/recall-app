#Understands Recall web application requests

require 'sinatra' 
require_relative './Note'
require_relative './RedisManager'

#TODO: how to avoid the creation of a redis manager every time?

@redisManager = RedisManager.new

get '/' do  
	@notes = {}
	@title = 'All Notes' 
	erb :home  
end  

post '/' do  
	note = Note.new(params[:content], false, Time.now, Time.now)
 	puts 'about to write...' + note.to_s
  # @recallManager.save(note)
	redirect '/'  
end  