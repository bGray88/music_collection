class Song < ApplicationRecord
  belongs_to :artist

  has_many :album_songs
  has_many :albums, through: :album_songs
  has_many :user_albums, through: :albums
  has_many :users, through: :user_albums

  validates :title, presence: true
  validates :create_year, presence: true
  validates :length, presence: true
end
