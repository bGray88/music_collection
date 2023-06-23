class Artist < ApplicationRecord
  has_many :users
  has_many :albums
  has_many :album_songs
  has_many :songs, through: :album_songs
end
