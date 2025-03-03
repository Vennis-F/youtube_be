Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: "api/v1/users/registrations",
        sessions: "api/v1/users/sessions"
      }
    end
  end

  mount BaseAPI, at: '/'
end