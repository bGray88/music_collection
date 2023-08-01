class UserAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album

  validates :user_id, uniqueness: { scope: :album_id, message: "Collected Item Already Catalogued" }
end
