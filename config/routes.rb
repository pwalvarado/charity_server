Rails.application.routes.draw do
  use_doorkeeper

  namespace :v1 do
    jsonapi_resources :users, except: [:destroy]
  end
end
