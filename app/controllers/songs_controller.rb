class SongsController < ApplicationController
  before_filter :authenticate!
  skip_before_filter :verify_authenticity_token 

  def index
    @songs = @user.songs
    render json: { status: 'success', songs: @songs.map{ |s| { id: s.id, name: s.name, artist: s.artist, url: s.song.url } } }
  end

  def create
    @song = @user.songs.build(params[:song])
    if @song.save
      render json: { status: 'success', song: { id: @song.id, name: @song.name, artist: @song.artist, url: @song.song.url } }
    else
      render json: { status: 'error', errors: @song.errors.full_messages }
    end
  end

  def show
    @song = Song.find(params[:id])
    redirect_to @song.song.url
  end

private
  def authenticate!
    @user = User.find_by_api_key(params[:api_key])
    if @user.nil?
      return render json: { status: 'error', message: 'You must be signed in to use the API.' }
    end
  end
end
