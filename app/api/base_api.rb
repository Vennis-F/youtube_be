class BaseAPI < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ message: e.message, code: 404 }, 404)
  end
    
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!({ message: e.message, code: 400 }, 400)
  end
  
  rescue_from(Rmt::Exceptions::Authentication) do |e|
    Rails.logger.error(e)
    error!({ message: e.message, code: 401 }, 401)
  end
  
  rescue_from Exception do |e|
    Rails.logger.error(e.message)

    Rails.logger.info('Logging first 20 lines of backtrace')
    e.backtrace.take(20).each { |line| Rails.logger.error line }

    error!({ message: e.message, code: 400 }, 400)
  end

  rescue_from :all do |e|
    error!({ message: e.message, code: 500 }, 500)
    Rails.logger.debug e
  end

  helpers do
    def get_jwt_token
      auth_header = headers['Authorization']
      return nil unless auth_header&.start_with?('Bearer ')
  
      auth_header.split(' ').last
    end
  
    def decode_jwt_token
      token = get_jwt_token
      return nil unless token

      secret_key = ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.secrets.secret_key_base
      begin
        decoded_token = JWT.decode(token, secret_key, true, { algorithm: 'HS256' })
        decoded_token.first
      rescue JWT::DecodeError => e
        Rails.logger.error("JWT Decode Error: #{e.message}")
        nil
      end
    end

    def authenticated!
      payload = decode_jwt_token
      unless payload && payload['sub']
        raise Rmt::Exceptions::Authentication, 'Unauthorized'
      end
    
      @current_user = User.find_by(id: payload['sub'])
      raise Rmt::Exceptions::Authentication, 'Unauthorized' unless @current_user
    end    
  end

  mount V1::Api
end
