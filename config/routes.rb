Rails.application.routes.draw do
  resources :asistencia
  resources :clientes
  resources :empleados
  get '/login', to: 'seguridad#index'
  post '/login', to: 'seguridad#acceder'
  delete '/logout',  to: 'seguridad#destroy'
  get '/home', to: 'home#index'
  post '/home', to: 'home#asistencia'
  root 'home#index'
end
