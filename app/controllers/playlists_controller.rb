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
      render json:  { status: 'success', playlist: { id: @playlist.id, name: @playlist.name }} 
    else
      render json:  { status: 'error', playlist: { id: @playlist.id, name: @playlist.name } message: @playlist.errors.messages} 
    end

  end

  def destroy
    @playlist = Playlist.find( params[:id] )
    if @playlist.delete
      render json: { status: 'success', playlist: { id: @playlist.id, name: @playlist.name }}
    else
      render json: {status: 'error', playlist: { id: @playlist.id, name: @playlist.name }, message: @playlist.errors.messages }
    end
  end

  def add_song(song)
    @playlist = Playlist.find( params[:id] )
    @playlist.songs << song
    if @playlist.save
      render json: { status: 'success', playlist: { id: @playlist.id, name: @playlist.name }, song: { id: song.id, name: song.name }}
    else
      render json: { status: 'error', playlist: { id: @playlist.id, name: @playlist.name }, message: @playlist.errors.messages }}
    end
    
  end

  def remove_song(song)
  end

end 
