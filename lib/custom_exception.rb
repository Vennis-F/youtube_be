class CustomException < StandardError
  attr_reader :details

  def initialize(details = {})
    @details = details
    super(details[:message] || "An error occurred")
  end
end