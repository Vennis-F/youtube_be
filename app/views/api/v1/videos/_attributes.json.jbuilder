json.id             video.id
json.title          video.title
json.url            video.url
json.shared_by      video.user.email
json.created_at     format_timestamp(video.created_at)
json.updated_at     format_timestamp(video.updated_at)