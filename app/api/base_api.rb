class BaseAPI < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ message: e.message, code: 404 }, 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!({ message: e.message, code: 400 }, 400)
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

  mount V1::Api

end
