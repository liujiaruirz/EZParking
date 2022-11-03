Feature: 

    As an user
    So that I can quickly see available parking spots on the map
    I want to see, edit and destroy spots information


Background: spots data added to database


  Given the following spots exist:
  | time2leave | latitude  | longitude  |
  | 30         | 40.807346 | -73.960714 |
  | 120        | 40.808479 | -73.963412 |
  | 1          | 40.804792 | -73.964156 |
  | 99         | 40.806054 | -73.961227 |
  | 10         | 40.0      | -15.0      |

  Given  I am on the spots page
  Then 5 seed spots should exist


Scenario: show spot detail
When I click Show 
Then I should see "Time to Leave"
Then I should see "Latitude"
Then I should see "Longitude"


Scenario: edit spot detail
When I click Edit 
And I fill in "Time2leave" with "15"
And I fill in "Latitude" with "50"
And I fill in "Longitude" with "-80"
And I press "Update Spot"
Then I should see "15" after "Time to Leave"
Then I should see "Longitude"
Then I should see "50.0" 
And I should see "50.0" after "Latitude"
And I should see "-80.0" after "Longitude"

#Scenario: destroy spot information
#Given  I am on the spots page
#When I click Destroy
#And I press "OK"


Scenario: add new spot
When I click New Spot
And I fill in "Time2leave" with "10"
And I fill in "Latitude" with "40"
And I fill in "Longitude" with "-15"
And I press "Create Spot"
Then I should see "10" after "Time to Leave" 
And I should see "40.0" after "Latitude"
And I should see "-15.0" after "Longitude"
