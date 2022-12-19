require 'rails_helper'
RSpec.describe "Users", type: :request do
  # test successful register - example 1
  # include Warden::Test::Helpers
  describe "POST /register" do
    scenario 'valid register' do
      @user = User.create!({
        :email => "23c@qq.com",
        :password => "123456",
        :password_confirmation => "123456"
      })
      # login_as @user
    
      user = User.find_by_email("23c@qq.com")
      expect(user.blank?).to eq(false)
    end
  end

  # test successful register - example 2
  describe "POST /register" do
    scenario 'valid register' do
      @user = User.create!({
        :email => "4134@gmail.com",
        :password => "641=a4",
        :password_confirmation => "641=a4"
      })
      user = User.find_by_email("4134@gmail.com")
      expect(user.blank?).to eq(false)
    end
  end

  # test register with duplicate email - example 1
  describe "POST /login" do
    scenario 'register with duplicate email' do
      @user = User.create!({
        :email => "cc@gmail.com",
        :password => "123456",
        :password_confirmation => "123456"
      })
      post '/users/', params: {
        user: {
          email: "cc@gmail.com",
          encrypted_password: "cfhasjdfa"
        }
      }
      expect(response.body).to include("Email has already been taken")
    end
  end

  # test register with duplicate email - example 2
  describe "POST /login" do
    scenario 'register with duplicate email' do
      @user = User.create!({
        :email => "n41@qq.com",
        :password => "534m43",
        :password_confirmation => "534m43"
      })
      post '/users/', params: {
        user: {
          email: "n41@qq.com",
          encrypted_password: "534m43"
        }
      }
      expect(response.body).to include("Email has already been taken")
    end
  end

  # test correct login - example 1
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

  # test correct login - example 2
  describe "POST /login" do
    scenario 'valid user login' do
      @user = User.create!({
        :email => "329@qq.com",
        :password => "kas;'f",
        :password_confirmation => "kas;'f"
      })
      user = User.find_by_email("329@qq.com")
      expect(user.valid_password?("kas;'f")).to eq(true)
    end
  end


  # test login with wrong password - example 1
  describe "POST /login" do
    scenario 'login with wrong password' do
      @user = User.create!({
        :email => "admin@admin",
        :password => "123456",
        :password_confirmation => "123456"
      })
      user = User.find_by_email("admin@admin")
      expect(user.valid_password?("fhaksjfha")).to eq(false)
    end
  end

    # test login with wrong password - example 2
    describe "POST /login" do
      scenario 'login with wrong password' do
        @user = User.create!({
          :email => "5j@qq.com",
          :password => "44523n",
          :password_confirmation => "44523n"
        })
        user = User.find_by_email("5j@qq.com")
        expect(user.valid_password?("ar;jernakjer")).to eq(false)
      end
    end

  # test login for unregistered user - example 1
  describe "POST /login" do
    scenario 'login for unregistered user' do
      user = User.find_by_email("145@qq.com")
      expect(user.blank?).to eq(true)
    end
  end

  # test login for unregistered user - example 2
  describe "POST /login" do
    scenario 'login for unregistered user' do
      user = User.find_by_email("3o1@qq.com")
      expect(user.blank?).to eq(true)
    end
  end

  # test forgot password with valid email - example 1
  describe "POST /login" do
    scenario 'forgot password with valid email' do
      @user = User.create!({
        :email => "admin@admin",
        :password => "123456",
        :password_confirmation => "123456"
      })

      post '/users/password', params: {
        Parameters: {
          "utf8"=>"✓", 
          "authenticity_token"=>"CbUeu15uT9Uu8bD8tSwEPr51I/5PdT5X/05gPkmVYfoLQs+yP/9kfM+7mEIXEh8VZbRCDmS6tyotYP42wIYiIQ==", 
          "user"=>{"email"=>"admin@admin"}, 
          "commit"=>"Send me reset password instructions"
        }
        # user: {
        #   email: "cc@qq.com",
        #   encrypted_password: "cfhasjdfa"
        # }
      }
      
      user = User.find_by_email("admin@admin")
      # puts(response.body)
      expect(user.send_reset_password_instructions.blank?).to eq(false)
      # expect(response.body).to include("You will receive an email with instructions on how to reset your password in a few minutes.")
    end
  end

  # test forgot password with valid email - example 2
  describe "POST /login" do
    scenario 'forgot password with valid email' do
      @user = User.create!({
        :email => "3n5@qq.com",
        :password => "123456",
        :password_confirmation => "123456"
      })

      post '/users/password', params: {
        Parameters: {
          "utf8"=>"✓", 
          "authenticity_token"=>"CbUeu15uT9Uu8bD8tSwEPr51I/5PdT5X/05gPkmVYfoLQs+yP/9kfM+7mEIXEh8VZbRCDmS6tyotYP42wIYiIQ==", 
          "user"=>{"email"=>"3n5@qq.com"}, 
          "commit"=>"Send me reset password instructions"
        }
      }
      
      user = User.find_by_email("3n5@qq.com")
      # puts(response.body)
      expect(user.send_reset_password_instructions.blank?).to eq(false)
      # expect(response.body).to include("You will receive an email with instructions on how to reset your password in a few minutes.")
    end
  end
  
    # test forgot password with invalid email - example 1
    describe "POST /login" do
      scenario 'forgot password with invalid email' do
        @user = User.create!({
          :email => "admin@admin",
          :password => "123456",
          :password_confirmation => "123456"
        })
  
        post '/users/password', params: {
          Parameters: {
            "utf8"=>"✓", 
            "authenticity_token"=>"CbUeu15uT9Uu8bD8tSwEPr51I/5PdT5X/05gPkmVYfoLQs+yP/9kfM+7mEIXEh8VZbRCDmS6tyotYP42wIYiIQ==", 
            "user"=>{"email" =>"4782@gmail.com"}, 
            "commit"=>"Send me reset password instructions"
          }
        }
        expect(response.body).to include("1 error prohibited this user from being saved:")
      end
    end

    # test forgot password with invalid email - example 2
    describe "POST /login" do
      scenario 'forgot password with invalid email' do
        @user = User.create!({
          :email => "1235@gmail.com",
          :password => "123456",
          :password_confirmation => "123456"
        })
  
        post '/users/password', params: {
          Parameters: {
            "utf8"=>"✓", 
            "authenticity_token"=>"CbUeu15uT9Uu8bD8tSwEPr51I/5PdT5X/05gPkmVYfoLQs+yP/9kfM+7mEIXEh8VZbRCDmS6tyotYP42wIYiIQ==", 
            "user"=>{"email" =>"aar3@gmail.com"}, 
            "commit"=>"Send me reset password instructions"
          }
        }
        expect(response.body).to include("1 error prohibited this user from being saved:")
      end
    end

    # test change password - example 1
    describe "POST /login" do
      scenario 'change password' do
        @user = User.create!({
          :email => "1235@gmail.com",
          :password => "123456",
          :password_confirmation => "123456"
        })
        # put '/users', params: {
        #   Parameters: {
        #     "utf8"=>"✓", 
        #     "user"=>{"email"=>"1235@gmail.com", 
        #     "password"=>"234567", 
        #     "password_confirmation"=>"234567", 
        #     "current_password"=>"123456"}, 
        #     "commit"=>"Update"
        #   }
        # }
        # user = User.find_by_email("1235@gmail.com")
        @user.reset_password("234567", "234567")
        expect(@user.valid_password?("234567")).to eq(true)
        expect(@user.valid_password?("1234567")).to eq(false)
        # puts(response.body)
        # expect(response.body).to include("Your account has been updated successfully.")
      end
    end
    describe "reward points" do
      scenario 'initial reward' do
        @user = User.create!({
          :email => "admin@admin",
          :password => "123456",
          :password_confirmation => "123456"
        })
        expect(@user.points).to eq(5)
      end
      scenario 'added reward' do
        @user = User.create!({
          :email => "admin@admin",
          :password => "123456",
          :password_confirmation => "123456"
        })
        @user.points += 1
        expect(@user.points).to eq(6)
      end
    end
end
