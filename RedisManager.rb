#Understands redis and its uses

require 'redis'
require 'yaml'

class RedisManager
	attr_reader :redis
  	protected :redis

  	def initialize
  		@config = YAML.load_file("./config/config.yaml")
		@redis = Redis.new(:host => @config["db_host"], :port => @config["db_port"], 
						   :password => @config["db_password"])
		@redis.select(@config["db_subset"])
  	end

	def save(note)  
		puts 'inserting...' + note.to_s
		key = @redis.get(@config["db_num_notes_key"])
		@redis.multi do
			@redis.sadd(@config["db_notes_index"], key)
			@redis.set(key, note.to_s);
			@redis.incr(@config["db_num_notes_key"])
    	end
	end

	def getAllNotes
		notes = []
		keys = @redis.smembers(@config["db_notes_index"])
		keys.each do |key|
			value = @redis.get(key)
			notes << Note.createNote(key, value)
		end
		notes
	end

end