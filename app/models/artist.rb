class Artist < ApplicationRecord
  has_many :songs
  has_many :albums
  has_many :user_albums, through: :albums
  has_many :users, through: :user_albums

  validates :name, presence: true
  validates :form_year, presence: true
end
