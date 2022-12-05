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
  describe "POST /users/sign_in" do
    it "returns http success" do
      # this will perform a GET request to the /health/index route
      @user = User.create!({
               :email => "amin@admin",
               :password => "123456",
               :password_confirmation => "123456"
             })
      encrypted_password = @user.encrypted_password
      
      
      post "/users/sign_in", params: {
        user: {
          :email => @user.email,
          :encrypted_password => @user.encrypted_password
        }
      }
      
      # sign_in @user
      # post "/users/sign_in", params: {
      #  user: @user
      # }
      expect(response.status).to eq(200)
      expect(response.body).to include("successful")
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
      # this will perform a GET request to the /health/index route
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


  describe "POST /register" do
    scenario 'valid register' do
      # send a POST request to /bookmarks, with these parameters
      # The controller will treat them as JSON 
      post '/users/', params: {
        user: {
          email: "20@qq.com",
          encrypted_password: "3wwwww0"
        }
      }
      expect(response.status).to eq(200)
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


