require 'rails_helper'

RSpec.describe "UserController", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "POST /api/v1/auth/sign_up" do
    it "creates a new business" do
      post_params = { first_name: "oye", last_name: "olalekan", email: "test@gmail.com", password: "password" }
      post "/api/v1/auth/sign_up", params: post_params
      expect(response).to have_http_status(:created)
      expect(User.count).to eq(1)
      expect(User.last.first_name).to eq("oye")
      expect(User.last.last_name).to eq("olalekan")
    end
  end

  describe "POST /api/v1/auth/login" do
    it "login user" do
      user_obj = FactoryBot.create(:user)
      header = {"Authorization" => "Bearer #{user_obj.token}"}
      post_params = { email: user_obj.email, password: user_obj.password }
      post "/api/v1/auth/login", params: post_params, headers: headers
      expect(response).to have_http_status(:ok)
      expect(User.count).to eq(1)
      expect(User.last.first_name).to eq(user_obj.first_name)
      expect(User.last.last_name).to eq(user_obj.last_name)
    end
  end

  describe "POST /api/v1/auth/change_password" do
    it "change password" do
      user_obj = FactoryBot.create(:user, password: "test")
      header = {"Authorization" => "Bearer #{user_obj.token}"}
      put_params = { old_password: user_obj.password, password: "test", password2: "test" }
      put "/api/v1/auth/change_password", headers: header, params: put_params
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/v1/auth/request_reset_password" do
    it "request password change" do
      user_obj = FactoryBot.create(:user, password: "test")
      params = { email: user_obj.email }
      post "/api/v1/auth/request_reset_password", params: params
      expect(response).to have_http_status(:ok)
      expect(ResetToken.count).to eq(1) 
      expect(ResetToken.last.user.email).to eq(user_obj.email)
    end
  end

  describe "POST /api/v1/auth/reset_password" do
    it "reset password change" do
      user_obj = FactoryBot.create(:reset_token, user: user)
      params = { link: user_obj.link, password: "oye" }
      post "/api/v1/auth/reset_password", params: params
      expect(response).to have_http_status(:ok)
      expect(ResetToken.count).to eq(1) 
      expect(ResetToken.last.user.email).to eq(user.email)
    end
  end
end