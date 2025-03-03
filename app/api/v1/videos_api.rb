class V1::VideosApi < Grape::API
  helpers V1::Helpers::SharedParamsHelper

  resources :videos do
    desc "Return all videos", tags: ['videos']
    # params do
    #   optional :q, type: String
    #   use :order, data_sort: %i(name created_at),
    #               default_data_sort: :created_at,
    #               default_order_sort: :desc
    # end
    # paginate
    get "/", jbuilder: "v1/videos/index" do
      @videos = Video.includes(:user).all
      @message = "Success"
    end

    before { authenticated! }

    desc 'Create a new video'
    params do
      requires :title, type: String, desc: 'Video title'
      requires :url, type: String, desc: 'YouTube video URL'
    end
    post "/", jbuilder: "v1/videos/show" do
      @video = ApisV1::VideoOperations::Create.new(params, @current_user).process
      @message = "Success"
    end
  end
end