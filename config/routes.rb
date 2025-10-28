Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   root "projects#index"
  # project/task routes
  resources :projects do
    member do
      patch :change_status
    end

    resources :tasks do
      member do
        patch :change_priority
        patch :change_status
      end

      # Employers assigned to a task
      get "employers", to: "tasks/employers#index"
      post "employers", to: "tasks/assignments#create"
      delete "employers/:employer_id", to: "tasks/assignments#destroy"
    end
  end

  resources :employers
end
