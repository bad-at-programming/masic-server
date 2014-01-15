MasicServer::Application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :songs

  resources :playlists

  match '/playlists/add/:id/:song_id', :to => 'playlists#add', :via => :post, :as => :add_song
end
