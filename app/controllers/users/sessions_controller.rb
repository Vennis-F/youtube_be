class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { message: 'Logged in successfully', user: resource, token: jwt_token(resource) }, status: :ok
  end

  def destroy
    sign_out(resource_name)
    head :no_content
  end

  private

  def jwt_token(user)
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end
end
