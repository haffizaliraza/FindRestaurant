Rails.application.routes.draw do
  devise_for :users, :controllers => { 
    :sessions => "users/sessions", registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  root "home#index"
  get 'dashboard', to: "admin/dashboard#index"
  get 'get_location', to: "home#get_location"
  get 'hotel/:id', to: "home#hotel", as: 'hotel'

  namespace :admin do
    resources :users, :locations

    resources :hotels do
      collection do
        post :import_file
      end
    end

    resources :products do
      collection do
        post :import_file
      end
    end

    resources :deals do
      collection do
        post :import_file
      end
    end
  end
end
