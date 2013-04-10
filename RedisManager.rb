#Understands redis and its use

require 'redis'
require 'yaml'

class RedisManager
	attr_reader :redis
  	protected :redis

  	def initialize
  		config = YAML.load_file("./config/config.yaml")
		@redis = Redis.new(:host => config["db_host"], :port => config["db_port"], 
						   :password => config["db_password"])
  	end

	def save(note)  
		puts 'inserting...' + note.to_s
		# @redis.multi do
  #     		@notes.each do |key, value|
		# 		redis.sadd(NOTES_INDEX, key)
		# 		redis.set(key, value);
		# 	end
  #   	end
	end

	#t = Time.at(i)
end