require 'rails_helper'

RSpec.describe 'Sessions API' do
  before(:each) do
    @user1 = create(:user)

    headers = { "CONTENT_TYPE" => "application/json" }
    post api_v1_login_path(login: { email: @user1.email, password: @user1.password }), headers: headers

    @user_token = response.header['X-AUTH-TOKEN']
    @headers = {
      "CONTENT_TYPE" => "application/json",
      'Authorization': @user_token
    }
  end

  describe "#Destroy" do
    it 'Will logout a user by destroying session values' do
      delete api_v1_logout_path, headers: @headers

      logout_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(logout_response).to have_key(:success)
      expect(logout_response[:success]).to include("Logged out successfully")
    end
  end
end
