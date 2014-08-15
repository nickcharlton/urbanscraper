module TimeUtils
  def time_for(value)
    case value
      when :yesterday then Time.now - 24*60*60
      when :tomorrow  then Time.now + 24*60*60
      else super
    end
  end
end
