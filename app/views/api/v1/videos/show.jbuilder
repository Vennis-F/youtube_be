json.code    200
json.message @message
json.data do
    json.partial! "v1/videos/attributes", video: @video
end