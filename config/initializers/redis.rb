$redisusers_online = Redis.new
$redis = Redis.new(url: ENV['REDIS_WEB_URL'])