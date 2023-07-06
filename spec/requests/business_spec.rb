require 'rails_helper'

RSpec.describe "BusinessController", type: :request do
    # Tests will go here
    describe "POST /api/v1/business/create_business" do
        it "creates a new business" do
          post_params = { title: "my organization" }
          post "/api/v1/business/create_business", params: { post: post_params }
    
          expect(response).to have_http_status(:created)
          expect(Business.count).to eq(1)
          expect(Business.last.title).to eq("Test business")
        end
    end

    describe "GET /api/v1/business/all_businesses" do
        it "returns all businesses for an authenticated user" do
          # Create a sample user
          user = User.create(email: "test@example.com", password: "password")
    
          # Simulate user authentication by creating a session
          post "/api/v1/auth/login", params: { email: user.email, password: "password" }
    
          # Retrieve the authentication token from the response
          authentication_token = JSON.parse(response.body)["authentication_token"]
    
          # Add the authentication token to the request headers for authentication
          headers = { "Authorization" => "Bearer #{authentication_token}" }
    
          # Create sample businesses in the database
          business1 = Business.create(title: "Business 1" )
          business2 = Business.create(title: "Business 2")
    
          # Make a GET request to the /api/v1/business/all_businesses endpoint with authentication headers
          get "/api/v1/business/all_businesses", headers: headers
    
          # Assert that the response is successful and returns a JSON array of businesses
          expect(response).to have_http_status(:success)
          expect(response.content_type).to eq("application/json")
          expect(JSON.parse(response.body)).to eq([
            { "id" => business1.id, "title" => "Business 1"  },
            { "id" => business2.id, "title" => "Business 2"  }
          ])
        end
    end
end