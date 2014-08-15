module ResponseUtils
  def valid_response?(result)
    definition = result[:definition]
    posted = result[:posted]

    if definition and posted
      return true
    else
      return false
    end
  end
end
