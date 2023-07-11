require 'rails_helper'

RSpec.describe "ProviderController", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:business) {FactoryBot.create(:business)}
    let(:headers) { { "Authorization" => "Bearer #{user.token}" } }

    describe "POST /api/v1/provider/add_provider/:slug" do

        it "should create new provider" do
          provider_obj = FactoryBot.create(:provider, business: business)
          post_params = { title: "my provider" }
          post "/api/v1/provider/add_provider/#{provider_obj.slug}/", params: post_params, headers: headers
          expect(response).to have_http_status(:created)
          expect(Provider.count).to eq(1)
          expect(Provider.last.title).to eq("my provider")
        end
    
    end

    describe "GET /api/v1/provider/all_providers" do

        before do
          FactoryBot.create_list(:provider, 4, business: business)
        end
    
        it "should fetch all created providers" do
          get "/api/v1/provider/all_providers", headers: headers
          expect(response).to have_http_status(:ok)
          expect(Provider.count).to eq(4)
        end
    
    end
    
end