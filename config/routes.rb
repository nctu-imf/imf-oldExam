Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'

  resources :courses do
    collection do
      get :download_file
    end
  end

  resources :grade

  get "/pages/:action" , :controller => "pages"
end
