require "faraday"
require "json"

Rails.application.config.after_initialize do
  page = 1
  all_videos = []
  max_pages = 10

  loop do
    begin
      # Create a Faraday connection object
      response = Faraday.get("https://mock-youtube-api-f3d0c17f0e38.herokuapp.com/api/videos?page=#{page}")

      if response.success?
        # Parse the response body (assuming it's JSON)
        videos_data = JSON.parse(response.body)

        break if videos_data["videos"].empty?

        Rails.logger.info "Fetched page #{page} with #{videos_data['videos'].size} videos"
        all_videos.concat(videos_data["videos"])
        page += 1

        # Stop fetching if we reach max pages
        break if page > max_pages
      else
        # Handle non-200 response
        Rails.logger.error "Failed to fetch videos: #{response.status}"
        break
      end

    rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
      # Handle timeouts and connection errors
      Rails.logger.error "Error fetching videos: #{e.message}"
      break
    rescue JSON::ParserError => e
      # Handle JSON parsing errors
      Rails.logger.error "Error parsing response JSON: #{e.message}"
      break
    end
  end

  Rails.cache.write(:youtube_videos, all_videos)
  Rails.logger.info "Total videos fetched: #{all_videos.size}"
end
