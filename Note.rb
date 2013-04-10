#Understands a recall note

class Note
  attr_reader :id, :content, :complete, :creationTime, :updateTime
  
  def initialize(id = nil, content, complete, creationTime, updateTime)
  	!id ? @id = -1 : @id = id
	@content, @complete, @creationTime, @updateTime = content, complete, creationTime.to_i, updateTime.to_i
  end

  def to_s
  	@content + ':' + @complete.to_s + ':' + @creationTime.to_s + ':' + @updateTime.to_s
  end

  def ==(other)
  	return false unless other.is_a? self.class
  	self.content == other.content && self.complete == other.complete && 
  	self.creationTime == other.creationTime && self.updateTime == other.updateTime
  end

  def self.createNote(id, redisValue)
  	fields = redisValue.split(':')
  	Note.new(id, fields[0], fields[1], Time.at(fields[2].to_i).to_s, Time.at(fields[3].to_i).to_s)
  end

end