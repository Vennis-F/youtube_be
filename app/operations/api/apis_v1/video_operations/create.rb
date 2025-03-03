class ApisV1::VideoOperations::Create < ApisV1::Base
  def process
    ActiveRecord::Base.transaction do
      video = current_user.videos.create!(video_params)
      # Send notification when a new video is shared
      # NotificationJob.perform_later(video)
      return video
    end
  end

  private

  def video_params
    {
      title: params[:title],
      url: params[:url]
    }
  end
end