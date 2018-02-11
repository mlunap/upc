Rails.application.routes.draw do
  get '/mapa', to: 'mapa#index'

  get '/reporte', to: 'reporte#index'
  get '/excel_asistencia', to: 'reporte#excel'

  resources :asistencia
  resources :clientes
  resources :empleados
  get '/login', to: 'seguridad#index'
  get '/login_edit', to: 'seguridad#edit'
  post '/login_edit', to: 'seguridad#update'
  post '/login', to: 'seguridad#acceder'
  delete '/logout',  to: 'seguridad#destroy'
  get '/home', to: 'home#index'
  post '/home', to: 'home#asistencia'
  root 'home#index'

end
