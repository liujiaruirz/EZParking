require 'rails_helper'

RSpec.describe "Spots", type: :request do
  describe "GET /index" do
    it "returns http success" do
      # this will perform a GET request to the /health/index route
      get "/spots"
      expect(response.status).to eq(200)
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

  # test successful register
  describe "POST /register" do
    scenario 'valid bookmark attributes' do
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

  # # test register with duplicate email
  # describe "POST /register" do 
  #   scenario 'duplicate email registration' do
  #     post '/users/', params: {
  #       user: {
  #         email: "39@qq.com",
  #         encrypted_password: "sdrhwl3"
  #       }
  #     }
  #     post '/users/', params: {
  #       user: {
  #         email: "39@qq.com",
  #         encrypted_password: "sdrhwl3"
  #       }
  #     }
  #     expect(response.body).to include("1 error prohibited this user from being saved:")
  #   end
  # end

  # test login example 1
  describe "POST /login" do
    scenario 'valid user login' do
      @user = User.create!({
        :email => "admin@admin",
        :password => "123456",
        :password_confirmation => "123456"
      })
      # post '/users/sign_in', params: {
      #   user: {
      #     email: "admin@admin",
      #     encrypted_password: "123456"
      #   }
      # }
      user = User.find_by_email("admin@admin")
      expect(user.valid_password?("123456")).to eq(true)
      # puts response.body
      # expect(response.status).to eq(200)
    end
  end

  # test register with duplicate email
  describe "POST /login" do
    scenario 'valid user login' do
      @user = User.create!({
        :email => "cc@qq.com",
        :password => "123456",
        :password_confirmation => "123456"
      })
      post '/users/', params: {
        user: {
          email: "cc@qq.com",
          encrypted_password: "cfhasjdfa"
        }
      }
      expect(response.body).to include("Email has already been taken")
    end
  end

  # test login with wrong password
  describe "POST /login" do
    scenario 'valid user login' do
      @user = User.create!({
        :email => "admin@admin",
        :password => "123456",
        :password_confirmation => "123456"
      })
      # post '/users/sign_in', params: {
      #   user: {
      #     email: "admin@admin",
      #     encrypted_password: "123456"
      #   }
      # }
      user = User.find_by_email("admin@admin")
      expect(user.valid_password?("fhaksjfha")).to eq(false)
    end
  end

  # test add going
  # describe "add going by 1" do
  #   scenario "user click add going" do
  #     # this will perform a GET request to the /health/index route
      
  #   end
  # end
  

  # duplicate register - email
  # sign in - incorrect password



  

# described "#expired?" do
#   it "return false if item is not expired and true if item is expired" do
#     expect(item.expired?).to eq(false)    travel 5.day    expect(item.expired?).to eq(true)
#   end
# end
end


