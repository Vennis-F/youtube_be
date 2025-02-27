Sidekiq.options[:default_job_options] = { 'retry' => false }

sidekiq_config = { url: ENV['REDIS_SIDEKIQ_URL'] }

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets.secret_key_base
Sidekiq::Web.set :sessions, false
Sidekiq::Web.class_eval do
  use Rack::Protection, origin_whitelist: [ENV['BASE_URL']] # resolve Rack Protection HttpOrigin
end

schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
