require 'redis'
require 'uri' 

NOTES_INDEX = 'recall:notes'

@notes = {
	"0" => "Top-up Oyster:true:_:_",
	"1" => "Do the shopping:false:_:_",
	"2" => "Finish Ruby task:true:_:_",
	"3" => "Clean the house:true:_:_",
	"4" => "Fix my bike:false:_:_",
	"5" => "Football match:true:_:_"
}

redisUrl = 'redis://localhost:6379/'
uri = URI.parse(redisUrl)
@redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

puts 'populating...'
@redis.multi do
	@notes.each do |key, value|
	@redis.sadd(NOTES_INDEX, key)
	@redis.set(key, value);
end
	
puts 'Notes saved'

end