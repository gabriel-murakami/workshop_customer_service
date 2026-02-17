Rails.application.routes.draw do
  unless Rails.env.production?
    mount Rswag::Ui::Engine => "/api-docs"
    mount Rswag::Api::Engine => "/api-docs"
  end

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: "web" do
    scope module: "controllers" do
      namespace :api do
        scope controller: :customers do
          resources :customers, only: %i[index create update destroy]
          get "customers/:search_param", action: :show
          patch "customers/:document_number/add_vehicle", action: :add_vehicle
        end

        scope controller: :vehicles do
          resources :vehicles, only: %i[index create update destroy]
          get "vehicles/:license_plate", action: :show
        end
      end
    end
  end
end
