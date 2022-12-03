Given /^a valid user$/ do
    @user = User.create!({
               :email => "amin@admin",
               :password => "123456",
               :password_confirmation => "123456"
             })
  end
  
  Given /^a logged in user$/ do
    Given "a valid user"
    visit signin_url
    fill_in "Email", :with => "amin@admin"
    fill_in "Password", :with => "123456"
    click_button "Log in"
  end