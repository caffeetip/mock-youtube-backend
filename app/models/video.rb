class Video < ApplicationRecord
  belongs_to :playlist

  validates :video_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :views, numericality: { only_integer: true, allow_nil: true }
  validates :description, presence: true
  validates :thumbnail_url, presence: true
end
