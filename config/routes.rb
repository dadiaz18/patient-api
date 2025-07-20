Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  resources :patients, only: [ :create ] do
    resource :adherence, only: [ :show ]
    resources :injections, only: [ :index, :create ]
  end
end
