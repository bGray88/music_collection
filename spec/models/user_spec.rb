require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    subject { create(:user) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
  end

  before(:each) do
    @users = create_list(:user, 5)
  end

  it "exists and has attributes" do
    expect(@users.first).to be_a(User)
  end
end
