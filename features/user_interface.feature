Feature: user interface 

    As an user
    So that I can quickly sign up for an account and log into my account
    I want to create and edit my account details


Background: user data added to database






Scenario: create an account

Given  I am on the sign up page
When I fill in "Email" with "1234@gmail.com"
And I fill in "Password" with "123456"
And I fill in "Password confirmation" with "123456"
When I press "Sign up" 
Then I should see "Welcome! You have signed up successfully."



Scenario: log into my account
Given  I am on the sign in page
And I fill in "Email" with "amin@admin"
And I fill in "Password" with "123456"
And I press "Log in" 
Then I should see "Invalid Email or password."



Scenario: log out of my account
Given I am on the spots page
When I click logout 
Then I should see "Welcome to EZParking!"

Scenario: Login
Given a valid user
When I go to the sign in page
And I fill in "Email" with "amin@admin"
And I fill in "Password" with "123456"
And I press "Log in" 
Then I should see "Signed in successfully."