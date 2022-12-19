require 'rails_helper'
require 'support/controller_helpers'
RSpec.describe "Spots", type: :request do
  describe "GET /index" do
    it "returns http success" do
      # this will perform a GET request to the /health/index route
      get "/spots"
      expect(response.status).to eq(302)
    end
  end
  
  
  describe "GET /newSpot" do
    it "returns http success" do
      # this will perform a GET request to the /health/index route
      get "/spots/new"
      expect(response.status).to eq(200)
    end
  end

  describe "POST /newSpot" do
    it "returns http success" do
      post '/spots', params: {
        spot: {
          time2leave: 20,
          latitude: 20,
          longitude: 20
        }
      }
      expect(response.status).to eq(302)
    end
  end

    
  end
  


end


