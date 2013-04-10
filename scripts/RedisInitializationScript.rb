require 'redis'
require 'uri' 
require 'yaml'

NOTES_INDEX = 'recall:notes'

notes = {
	"0" => "Top-up Oyster:true:1365605822:1365605822",
	"1" => "Do the shopping:false:1365605822:1365605822",
	"2" => "Finish Ruby task:true:1365605822:1365605822",
	"3" => "Clean the house:true:1365605822:1365605822",
	"4" => "Fix my bike:false:1365605822:1365605822",
	"5" => "Football match:true:1365605822:1365605822"
}

config = YAML.load_file("../config/config.yaml")


redis = Redis.new(:host => config["db_host"], :port => config["db_port"], :password => config["db_password"])

puts 'Starting populating...'
redis.multi do
	notes.each do |key, value|
		puts "Saving (key, value) = (#{key}, #{value})"
		redis.sadd(NOTES_INDEX, key)
		redis.set(key, value);
	end
end

puts 'Notes saved'