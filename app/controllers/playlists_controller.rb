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

  def add_video
    playlist = Playlist.find(params[:id])

    video_params = params.permit(:title, :video_id, :views, :description, :thumbnail_url)

    video = playlist.videos.new(video_params)

    if video.save
      playlist.videos << video unless playlist.videos.include?(video)

      render json: { message: "Video added to playlist", playlist: playlist }, status: :ok
    else
      render json: { error: video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def remove_video
    playlist = Playlist.find(params[:id])
    video_id = params[:video_id]

    video = playlist.videos.find_by(video_id: video_id)

    if video
      playlist.videos.delete(video)
      render json: { message: "Video removed from playlist", playlist: playlist }, status: :ok
    else
      render json: { error: "Video not found in the playlist" }, status: :not_found
    end
  end

  def get_videos
    playlist = Playlist.find(params[:id])
    videos = playlist.videos

    render json: { playlist_id: playlist.id, videos: videos }, status: :ok
  end

  private

  def playlist_params
    params.permit(:name)
  end
end
