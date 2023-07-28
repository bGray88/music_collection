class Album < ApplicationRecord
  belongs_to :artist

  has_many :album_songs
  has_many :songs, through: :album_songs
  has_many :user_albums
  has_many :users, through: :user_albums

  validates :title, presence: true
  validates :release_year, presence: true
  validates :genre, presence: true
  validates :image, presence: true
end
