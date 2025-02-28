json.code     200
json.message  @message
json.data @videos do |video|
  json.partial! "v1/videos/attributes", video: video
end
# json.partial! 'v1/shared/pagination', resources: @broadcast_emails
