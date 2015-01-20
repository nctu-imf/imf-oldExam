Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'

  resources :courses do
    collection do
      get :inform
      get :download_file
      get :search
    end
  end

  resources :grade

  resources :bullets

  get "/pages/:action" , :controller => "pages"
end
