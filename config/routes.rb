Rails.application.routes.draw do
  root 'static_pages#home'



  get '/am_checklist', to: 'days#am_checklist'
  post '/am_checklist', to: 'days#checklist'
  resources :days do
    member do
      get :summary, :emergency_restock_page, :close_page, :pm_checklist, :final_restock_page, :leave_note
      patch '/emergency_restock', to: 'days#emergency_restock'
      patch '/final_restock', to: 'days#final_restock'
      patch '/close', to: 'days#close'
      patch '/leave_note', to: 'days#note'
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
  post '/inventory', to: 'admin#inventory'
  post '/checklists', to: 'admin#checklists'

end
