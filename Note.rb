#Understands a recall note

class Note
  attr_reader :content, :complete, :creationTime, :updateTime
  protected :content, :complete, :creationTime, :updateTime 
  
  def initialize(content, complete, creationTime, updateTime)
	@content = content
    @complete = complete
    @creationTime = creationTime.to_i
    @updateTime = updateTime.to_i
  end

  def to_s
  	@content + ':' + @complete.to_s + ':' + @creationTime.to_s + ':' + @updateTime.to_s
  end

  def ==(other)
  	return false unless other.is_a? self.class
  	self.content == other.content && self.complete == other.complete && 
  	self.creationTime == other.creationTime && self.updateTime == other.updateTime
  end

end