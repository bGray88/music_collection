require "rails_helper"

RSpec.describe Album, type: :model do
  before(:each) do
    @artist = create(:artist)
    @albums = create_list(:album, 5, artist: @artist)
  end

  describe "validations" do
    subject { create(:album, artist: @artist) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:release_year) }
    it { should validate_presence_of(:genre) }
  end

  it "exists and has attributes" do
    expect(@albums.first).to be_a(Album)
  end
end
