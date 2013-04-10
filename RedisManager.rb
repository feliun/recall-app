#Understands redis and its use

require 'redis'

class RedisManager
	attr_reader :redis
  	protected :redis

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