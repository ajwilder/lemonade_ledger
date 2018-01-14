Rails.application.routes.draw do
  root 'static_pages#home'


  patch '/close', to: 'days#close'
  resources :days do
    member do
      get :summary, :restock, :close_page
    end
  end


  resources :items
  resources :sales

  get '/home', to: 'static_pages#home'
end
