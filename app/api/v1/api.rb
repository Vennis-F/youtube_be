# frozen_string_literal: true
require 'grape-swagger'
if ENV['RAILS_ENV'] == 'development'
  require 'grape_logging'
end

class V1::Api < Grape::API
  prefix 'api/v1'

  # Generate a properly formatted 404 error for all unmatched routes except '/'
  if ENV['RAILS_ENV'] == 'development'
    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, { logger: logger }
  end
  route :any, '*path' do
    error!({ error:  'Not Found',
             detail: "No such route '#{request.path}'",
             status: '404' },
           404)
  end

  # mount all apis need authentication below the before filter
  mount V1::UsersApi
end
