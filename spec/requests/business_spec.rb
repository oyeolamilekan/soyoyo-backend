require 'rails_helper'

RSpec.describe "BusinessController", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { "Authorization" => "Bearer #{user.token}" } }

  describe "POST /api/v1/business/create_business" do

    it "creates a new business" do
      post_params = { title: "my organization" }
      post "/api/v1/business/create_business", params: post_params, headers: headers
      expect(response).to have_http_status(:created)
      expect(Business.count).to eq(1)
      expect(Business.last.title).to eq("my organization")
    end

  end

  describe "GET /api/v1/business/all_businesses" do

    before do
      FactoryBot.create_list(:business, 4, user: user)
    end

    it "fetch business created" do
      get "/api/v1/business/all_businesses", headers: headers
      expect(response).to have_http_status(:ok)
      expect(Business.count).to eq(4)
    end

  end

  describe "GET /api/v1/business/api_keys/:slug" do

    it "fetch api keys" do
      business_obj = FactoryBot.create(:business, user: user)
      get "/api/v1/business/api_keys/#{business_obj.slug}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(ApiKey.count).to eq(1)
    end
    
  end

  describe "POST /api/v1/business/generate_api_key/:business_slug" do

    it "generate api keys" do
      business_obj = FactoryBot.create(:business, user: user)
      post "/api/v1/business/generate_api_key/#{business_obj.slug}/", headers: headers
      expect(response).to have_http_status(:ok)
    end
    
  end

  describe "PATCH /api/v1/business/edit_business/:business_slug" do

    it "edit business" do
      post_params = { title: "my organization" }
      business_obj = FactoryBot.create(:business, user: user)
      patch "/api/v1/business/edit_business/#{business_obj.slug}/", headers: headers, params: post_params
      business_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(business_response["data"]["title"]).to eq("my organization")
    end
    
  end
  
end