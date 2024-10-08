class YoutubeVideosController < ApplicationController
  # Get /youtube_vidoes
  def index
    page = params[:page] || 1
    title = params[:title]

    # Fetch videos from a cached store
    # videos = Rails.cache.read(:youtube_vidoes) || []

    file_path = Rails.root.join("data.json")
    videos = JSON.parse(File.read(file_path))

    # Filter by title if title param is provided
    if title.present?
      videos = videos.select { |video| video["title"].downcase.include?(title.downcase) }
    end

    total = videos.size

    # Paginate the results
    per_page = 10
    paginated_videos = videos.paginate(page: page.to_i, per_page: per_page)

    render json: {
      total: total,
      page: page,
      videos: paginated_videos
    }
  end
end
