MasicServer::Application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :songs


  # Allows for uri's of the form '/playlists/:id/add_song'
  resources :playlists do 
    # Provides route helper add_song_playlist_path(@playlist)
    member do
      post :add_song
    end
  end

end
