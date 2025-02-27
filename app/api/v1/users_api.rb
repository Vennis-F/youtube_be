class V1::UsersApi < Grape::API
  helpers V1::Helpers::SharedParamsHelper

  resources :users do
    desc "Return all users", tags: ['users']
    get "/" do
      @message = "Hello world"
    end
  end
end