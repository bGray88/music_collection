class User < ApplicationRecord
  has_many :albums
  has_many :album_songs
  has_many :songs, through: :album_songs
  has_many :artists, through: :albums

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  has_secure_password

  enum role: { default: 0 }

  validates :role, presence: true
end
