class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      token = generate_jwt(resource)

      response.set_cookie(:auth_token, {
        value: token,
        httponly: true,
        secure: Rails.env.production?,
        same_site: :lax,
        expires: 1.week.from_now
      })
      
      render json: { message: "User created successfully", data: resource }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def generate_jwt(user)
    payload = { user_id: user.id, exp: 1.week.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
