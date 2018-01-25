Rails.application.routes.draw do
  root 'static_pages#home'


  patch '/close', to: 'days#close'
  patch '/restock', to: 'days#restock'
  resources :days do
    member do
      get :summary, :restock_page, :close_page
    end
  end


  resources :items do
    member do
      get :delete
    end
  end
  resources :sales


  # Routes to authenticate the device
  get '/home', to: 'static_pages#home'
  get '/login', to: 'static_pages#login'
  post '/login', to: 'static_pages#authenticate'

  # Admin Routes
  get '/admin_login', to: 'admin#admin_login'
  post '/admin', to: 'admin#authenticate'
  get '/admin', to: 'admin#admin_page'
  get '/admin_logout', to: 'admin#logout'
  post '/employees', to: 'admin#employees'
  post '/locations', to: 'admin#locations'
  post '/update_admin', to: 'admin#update_admin'

end
