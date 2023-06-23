class CreateJoinTableAlbumSong < ActiveRecord::Migration[7.0]
  def change
    create_table :album_songs do |t|
      t.references :album, foreign_key: true
      t.references :song, foreign_key: true
    end
  end
end
