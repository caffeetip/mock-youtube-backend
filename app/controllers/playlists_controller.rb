class PlaylistsController < ApplicationController
  # GET / playlists
  def index
    playlists = Playlist.all
    render json: playlists
  end

  # GET /playlists/:id
  def show
    playlist = Playlist.find(params[:id])
    render json: playlist
  end

  # POST /playlists
  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      render json: playlist, status: :created
    else
      render json: playlist.errors, status: :unprocessable_entity
    end
  end

  # PUT /playlists/:id
  def update
    playlist = Playlist.find(params[:id])
    if playlist.update(playlist_params)
      render json: playlist
    else
      render json: playlist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlists/:id
  def destroy
    playlist = Playlist.find(params[:id])
    playlist.destroy
    head :no_content
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
