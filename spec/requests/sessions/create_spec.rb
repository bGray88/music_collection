require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe '#Create' do
    it 'can create a login' do
      user_params = {
        email: 'jimmyjoe@gmail.com',
        first_name: 'Jimmy',
        last_name: 'Joe',
        password: '474E5a5s12',
        password_confirmation: '474E5a5s12'
      }
      headers = { "CONTENT_TYPE" => "application/json" }

      post api_v1_register_path, headers: headers, params: JSON.generate(user: user_params)

      post api_v1_login_path(login: { email: user_params[:email], password: user_params[:password] }), headers: headers

      expect(response).to be_successful
      expect(response.body).to include("Logged in successfully")
    end

    it 'can notify if authentication fails' do
      user_params = {
        email: 'jimmyjoe@gmail.com',
        first_name: 'Jimmy',
        last_name: 'Joe',
        password: '474E5a5s12',
        password_confirmation: '474E5a5s12'
      }
      headers = { "CONTENT_TYPE" => "application/json" }

      post api_v1_register_path, headers: headers, params: JSON.generate(user: user_params)

      post api_v1_login_path(login: { email: user_params[:email], password: 'dfkhksdfh' }), headers: headers

      expect(response).to_not be_successful
      expect(response.body).to include("Unable to locate or authenticate user")
    end
  end
end
