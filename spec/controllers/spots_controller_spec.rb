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


  
      # response should have HTTP Status 201 Created
      
  
      # json = JSON.parse(response.body).deep_symbolize_keys
      
      # # check the value of the returned response hash
      # expect(json[:time2leave]).to eq(10)
      # expect(json[:latitude]).to eq(10)
    
  end
  

# described "#expired?" do
#   it "return false if item is not expired and true if item is expired" do
#     expect(item.expired?).to eq(false)    travel 5.day    expect(item.expired?).to eq(true)
#   end
# end
end


