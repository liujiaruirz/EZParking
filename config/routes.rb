Rails.application.routes.draw do
  resources :lists
  resources :spots do
    collection do
      get :add_going
    end
  end
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "spots#index"
  authenticated :user do
    root to: "spots#index"
  end
  
  unauthenticated :user do
    root to: "home#index"
  end
  
  

end

Rails.application.routes.default_url_options[:host] = "localhost:3000"