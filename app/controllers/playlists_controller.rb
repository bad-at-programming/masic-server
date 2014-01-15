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
      render json:  { status: 'error', playlist: { id: @playlist.id, name: @playlist.name }, message: @playlist.errors.messages} 
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


  # Custom route of the form /playlists/add/:id/:song_id to add a song to the playlist
  def add
    @playlist = Playlist.find( params[:id] )
    @song = Song.find( params[:song_id] )
    if belongs_to_user?(current_user, @playlist, @song)
      @playlist.songs << @song
      if @playlist.save
        render json: { status: 'success', playlist: { id: @playlist.id, name: @playlist.name }, song: { id: @song.id, artist: @song.artist, name: @song.name }}
      else
        render json: { status: 'error', playlist: { id: @playlist.id, name: @playlist.name }, song: { id: @song.id, artist: @song.artist, name: @song.name }}
      end
      
    else
      render json: { status: 'error', message: 'You do not own this song or playlist' }
    end
  end

  def remove_song(song)
  end

  private

    def belongs_to_user?(user, playlist, song)
      user.playlists.include?(playlist) && user.songs.include?(song)
    end

end 
