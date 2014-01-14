MasicServer::Application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :songs

  resources :playlists
end
