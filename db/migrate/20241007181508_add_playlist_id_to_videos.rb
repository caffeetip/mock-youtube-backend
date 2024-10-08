class AddPlaylistIdToVideos < ActiveRecord::Migration[7.2]
  def change
    add_reference :videos, :playlist, null: false, foreign_key: true
  end
end
