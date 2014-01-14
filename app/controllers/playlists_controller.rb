class PlaylistsController < ApplicationController

  def new
    @playlist = current_user.playlists.build
  end

  def index
    @playlists = current_user.playlists
  end

  def create
    @playlist = current_user.playlists.build( params[:playlist] )
    if @playlist.save
      render json:  "{ status: Success, message: Playlist id #{@playlist.id} has been created" 
    else
      render json:  "{ status: Failure, message: Failed to create the playlist: #{@playlist.errors.messages} }" 
    end

  end

  def destroy
  end

  def add_song(song)
  end

  def remove_song(song)
  end

end 
