class YoutubeVideosController < ApplicationController
  # Get /youtube_vidoes
  def index
    page = params[:page] || 1
    title = params[:title]

    # Fetch videos from a cached store
    videos = Rails.cache.read(:youtube_vidoes) || []

    # Filter by title if title param is provided
    if title.present?
      videos = videos.select { |video| video["title"].downcase.include?(title.downcase) }
    end

    # Paginate the results
    paginated_videos = videos.paginate(page: page.to_i, per_page: 10)

    render json: paginated_videos
  end
end
