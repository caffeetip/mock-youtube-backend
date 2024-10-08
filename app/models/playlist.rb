class Playlist < ApplicationRecord
  has_many :videos, dependent: :destroy
end
