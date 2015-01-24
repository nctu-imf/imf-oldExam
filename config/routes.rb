Rails.application.routes.draw do
 
  devise_for :users
  root 'home#index'

  resources :courses do
    collection do
      get :dashboard
      get :inform
      get :download_file
      get :search
    end
  end

  resources :grade do
    collection do
      get :download
    end
  end

  resources :bullets

  resources :users

  get "/pages/:action" , :controller => "pages"
end
