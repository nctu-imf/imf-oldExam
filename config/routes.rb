Rails.application.routes.draw do
  resources :courses do
    collection do
      get :download_file
    end
  end
  

  devise_for :users

  root 'courses#index'

  get "/pages/:action" , :controller => "pages"
end
