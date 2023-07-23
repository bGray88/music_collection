require 'rails_helper'

RSpec.describe 'Users API' do
  describe '#Show' do
    it 'can find a user by email and authenticate using password' do
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

      user_token = response.header['X-AUTH-TOKEN']
      headers = {
        "CONTENT_TYPE" => "application/json",
        'Authorization': user_token
      }

      get api_v1_user_path(user: { email: user_params[:email], password: user_params[:password] }), headers: headers

      expect(response).to be_successful

      created_user = JSON.parse(response.body, symbolize_names: true)[:data].first

      expect(created_user[:attributes][:email]).to eq(user_params[:email])
      expect(created_user[:attributes][:first_name]).to eq(user_params[:first_name])
      expect(created_user[:attributes][:last_name]).to eq(user_params[:last_name])
      expect(created_user[:attributes][:password]).to eq(user_params[:password_digest])
    end

    it 'notifies of errors due to missing attributes' do
      user_params = {
        email: 'jimmyjoe@gmail.com',
        first_name: 'Jimmy',
        last_name: 'Joe',
        password: '474E5a5s12',
        password_confirmation: '474E5a5s12'
      }
      headers = { "CONTENT_TYPE" => "application/json" }

      post api_v1_register_path, headers: headers, params: JSON.generate(user: user_params)

      get api_v1_user_path(user: { email: "peewee@gmail.com" }), headers: headers

      expect(response).to_not be_successful
      expect(response.body).to include("Nil JSON web token")
    end
  end
end
