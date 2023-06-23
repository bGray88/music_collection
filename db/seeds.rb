AlbumSong.delete_all
UserAlbum.delete_all
Song.delete_all
Album.delete_all
Artist.delete_all
User.delete_all

user1   = FactoryBot.create(:user)
artist1 = FactoryBot.create(:artist)
album1  = FactoryBot.create(:album, artist: artist1)
song1   = FactoryBot.create(:song, artist: artist1)

# user_album1 = UserAlbum.create(user: user1, album: album1)
# album_song1 = AlbumSong.create(album: album1, song: song1)

user1.albums << album1
album1.songs << song1
