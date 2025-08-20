Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  get    "/quests",      to: "quests#index",  as: :quests
  post   "/quests",      to: "quests#create", as: :create_quest
  patch  "/quests/:id",  to: "quests#update", as: :update_quest
  put    "/quests/:id",  to: "quests#update", as: :put_quest
  delete "/quests/:id",  to: "quests#destroy", as: :destroy_quest
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  get "/brag" => "brag#index", as: :brag
  root "quests#index"
  get "*path", to: redirect("/")
end
