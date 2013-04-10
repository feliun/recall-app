require 'redis'
require 'uri' 
require 'sinatra' 

class RecallManager
	NOTES_INDEX = 'recall:notes'

	@notes = {
			  "0" => "Top-up Oyster:true:_:_",
           	  "1" => "Do the shopping:false:_:_",
           	  "2" => "Finish Ruby task:true:_:_",
              "3" => "Clean the house:true:_:_",
           	  "4" => "Fix my bike:false:_:_",
           	  "5" => "Football match:true:_:_"
         	}

    def self.configureRedis
		redisUrl = 'redis://localhost:6379/'
		uri = URI.parse(redisUrl)
		@redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
		populateRedis
	end  

	def self.populateRedis()  
		puts 'populating...'
		@redis.multi do
      		@notes.each do |key, value|
				@redis.sadd(NOTES_INDEX, key)
				@redis.set(key, value);
			end
    	end
		puts 'Notes saved'
	end

	def save(note)  
		puts 'inserting...' + note
		# @redis.multi do
  #     		@notes.each do |key, value|
		# 		redis.sadd(NOTES_INDEX, key)
		# 		redis.set(key, value);
		# 	end
  #   	end
	end
end

puts 'configuring...'
RecallManager.configureRedis

get '/' do  
  @notes = {}
  @title = 'All Notes' 
  @recallManager = RecallManager.new
  erb :home  
end  

post '/' do  
  note = params[:content] + ':' + 'false' + ':' + Time.now.to_s + ':' + Time.now.to_s
  puts 'about to write...' + "#{note}"
  # @recallManager.save(note)
  redirect '/'  
end  