Rails.application.routes.draw do
  resources :requirements
  get 'log/index'
  get 'sessions/new'
  get 'users/new'
  resources :devices
  resources :types
  resources :people
  resources :filials
  resources :users
  root 'devices#index'
  get  '/log',  to: 'log#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  'edit_right',  to: 'users#edit_right'
  post 'edit_right',  to: 'users#edit_right'  
  post 'filter_filial' => 'devices#filter_filial'
  post 'filter_all' => 'devices#filter_all'
  get 'filter_all' => 'devices#filter_all'
#  get 'histories_path' => 'devices#histories_path'
#  mount Tail::Engine, at: "/tail"
  post 'search' => 'devices#search'
  get '/search' => 'devices#search'
  post 'export_dev' => 'filials#export_dev'
  post 'export_req' => 'requirements#export_req'
  post 'export_type' => 'types#export_type'
  post 'exportall_dev' => 'filials#exportall_dev'  
  get 'exportall_dev' => 'filials#exportall_dev'
  get  'export_dev' => 'filials#export_dev'
  post 'filter_type'   => 'devices#filter_type'
  post 'filter_iswork' => 'devices#filter_iswork'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  match '*unmatched', to: 'application#route_not_found', via: :all
#А чтобы перестать беспокоиться и начать жить, надо в routes.rb в конец написать что нибудь типа этого
#match "*path", :to => "errors#not_found"
#Сделать соответствующий контроллер и забыть.
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
