Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :playlists do
    member do
      post "add_video", to: "playlists#add_video"    # Add a video to the playlist
      delete "remove_video/:video_id", to: "playlists#remove_video"  # Remove a video from the playlist
      get "videos", to: "playlists#get_videos"       # Get videos for the playlist
    end
  end

  get "youtube_videos", to: "youtube_videos#index"
end
