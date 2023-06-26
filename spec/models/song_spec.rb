require "rails_helper"

RSpec.describe Song, type: :model do
  before(:each) do
    @artist = create(:artist)
    @songs  = create_list(:song, 5, artist: @artist)
  end

  describe "validations" do
    subject { create(:song, artist: @artist) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:create_year) }
    it { should validate_presence_of(:length) }
  end

  it "exists and has attributes" do
    expect(@songs.first).to be_a(Song)
  end
end
