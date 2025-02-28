class Apis::Base
  attr_reader :current_user, :params

  # @param params [Hash]
  # @param current_user [User]
  def initialize(params, current_user = nil)
    @params       = params
    @current_user = current_user
  end
end
