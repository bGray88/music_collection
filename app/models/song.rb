class Song < ApplicationRecord
  belongs_to :artist

  has_many :albums
  has_many :users
end
