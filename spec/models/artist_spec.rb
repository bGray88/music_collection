require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "validations" do
    subject { create(:artist) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:api_id) }
  end

  before(:each) do
    @artists = create_list(:artist, 5)
  end

  it "exists and has attributes" do
    expect(@artists.first).to be_a(Artist)
  end
end
