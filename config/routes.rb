Rails.application.routes.draw do
  root 'static_pages#home'

  resources :days do
    member do
      get :summary, :restock, :close
    end
  end


  resources :items
  resources :sales

  get '/home', to: 'static_pages#home'
end
