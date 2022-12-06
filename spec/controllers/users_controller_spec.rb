require 'rails_helper'
require 'support/controller_helpers'

RSpec.describe "Users", type: :request do
    describe "POST /users/sign_in" do
        it "returns correct password" do
          # this will perform a GET request to the /health/index route
          @user = User.create!({
                   :email => "amin@admin",
                   :password => "123456",
                   :password_confirmation => "123456"
                 })
          expect(@user.valid_password?('123456')).to be_truthy
        end
        it "returns incorrect password" do
            # this will perform a GET request to the /health/index route
            @user = User.create!({
                     :email => "amin@admin",
                     :password => "123456",
                     :password_confirmation => "123456"
                   })
            expect(@user.valid_password?('123455')).to be_falsey
          end
    end
    describe "POST /users/sign_up" do
        it "correct sign up 1" do
          # this will perform a GET request to the /health/index route
          @user = User.create!({
                   :email => "amin@admin",
                   :password => "123456",
                   :password_confirmation => "123456"
                 })
          expect(@user.valid_password?('123456')).to be_truthy
        end
        it "correct sign up 2" do
            # this will perform a GET request to the /health/index route
            @user = User.create!({
                     :email => "admin@admin",
                     :password => "654321",
                     :password_confirmation => "654321"
                   })
            expect(@user.valid_password?('654321')).to be_truthy
          end
        it "duplicate email sign up" do
            # this will perform a GET request to the /health/index route
            @user1 = User.create!({
                     :email => "amin@admin",
                     :password => "123456",
                     :password_confirmation => "123456"
                   })
            expect{User.create!({
                    :email => "amin@admin",
                    :password => "1234567",
                    :password_confirmation => "1234567"
            })}.to raise_error(ActiveRecord::RecordInvalid)
            
          end
          it "duplicate email sign up 2" do
            # this will perform a GET request to the /health/index route
            @user1 = User.create!({
                     :email => "amin@admin",
                     :password => "123456",
                     :password_confirmation => "123456"
                   })
            @user2 = User.create!({
                :email => "admin@admin",
                :password => "123456",
                :password_confirmation => "123456"
            })
            expect{User.create!({
                    :email => "admin@admin",
                    :password => "1234567",
                    :password_confirmation => "1234567"
            })}.to raise_error(ActiveRecord::RecordInvalid)
            
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
    end
end