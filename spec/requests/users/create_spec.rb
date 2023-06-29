require 'rails_helper'

RSpec.describe 'Users API' do
  describe '#Create' do
    it 'can create a new user' do
      user_params = {
        email: 'jimmyjoe@gmail.com',
        first_name: 'Jimmy',
        last_name: 'Joe',
        password: '474E5a5s12',
        password_confirmation: '474E5a5s12'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)

      created_user = User.last

      expect(response).to be_successful
      expect(created_user.email).to eq(user_params[:email])
      expect(created_user.first_name).to eq(user_params[:first_name])
      expect(created_user.last_name).to eq(user_params[:last_name])
      expect(created_user.password).to eq(user_params[:password_digest])
    end

    it 'notifies of errors due to missing attributes' do
      user_params = {
        email: 'jimmyjoe@gmail.com',
        first_name: 'Jimmy',
        password: '474E5a5s12',
        password_confirmation: '474E5a5s12'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.body).to include("Last name can\'t be blank")
    end
  end
end
