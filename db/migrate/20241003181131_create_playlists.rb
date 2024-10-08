class CreatePlaylists < ActiveRecord::Migration[7.2]
  def change
    add_reference :videos, :playlist, foreign_key: true
  end
end
