Feature: 

    As an user
    So that I can quickly see available parking spots on the map
    I want to see, edit and destroy spots information


Background: spots data added to database


  Given the following spots exist:
  |id| time2leave | latitude  | longitude  | going |
  |1 | 2022-11-18 20:30:01    | 40.807346 | -73.960714 | 0 |
  |2 | 2022-11-19 20:05:01    | 40.808479 | -73.963412 | 0 |
  |3 | 2022-11-20 20:00:01    | 40.804792 | -73.964156 | 0 |
  |4 | 2022-11-18 20:20:01    | 40.806054 | -73.961227 | 0 |
  |5 | 2022-11-17 20:10:01    | 40.0      | -15.0      | 0 |

  Given  I am on the spots page
  Then 5 seed spots should exist


Scenario: show spot detail
When I click Show 
Then I should see "Time to Leave"
Then I should see "Latitude"
Then I should see "Longitude"


Scenario: edit spot detail
When I click Edit 
And I fill in "Time2leave" with "2022-11-17 20:18:01"
And I fill in "Latitude" with "50"
And I fill in "Longitude" with "-80"
And I press "Update Spot"
Then I should see "2022-11-17 20:18:01" after "Time to Leave"
Then I should see "Longitude"
And I should see "50.0" after "Latitude"
And I should see "-80.0" after "Longitude"

#Scenario: destroy spot information
#Given  I am on the spots page
#When I click Destroy
#And I press "OK"


Scenario: add new spot
When I click New Spot
And I fill in "Time2leave" with "2023-10-25 09:10:30"
And I fill in "Latitude" with "80"
And I fill in "Longitude" with "40"
And I press "Create Spot"
Then I should see "Time to Leave" 
And I should see "2023-10-25 09:10:30"  
And I should see "80" after "Latitude"
And I should see "40" after "Longitude"


Scenario: user going to the spot
Given a valid spot
When I follow the first "Show" 
And I follow "Going"
Then I should see "You successfully add it to your going."

Scenario: user going to the same spot again
Given a valid spot
When I follow the first "Show" 
And I follow "Going"
And I follow the first "Show" 
And I follow "Going"
Then I should see "You have already added it."

Scenario: show time to leave for non-available spot with mins
Given a valid spot
When I travel to "2023-10-25 08:40:30"
And I am on the spots page
Then I should see "30 mins"

Scenario: show time to leave for non-available spot with mins and secs
Given a valid spot
When I travel to "2023-10-25 08:59:00"
And I am on the spots page
Then I should see "11 mins 30 secs"

Scenario: show time to leave for non-available spot with hours, mins and secs
Given a valid spot
When I travel to "2023-10-25 07:59:00"
And I am on the spots page
Then I should see "1 hours 11 mins 30 secs"

Scenario: show time to leave for available spot1 
Given a valid spot
When I travel to "2023-10-25 09:11:00"
And I am on the spots page
Then I should see "Available"

Scenario: show time to leave for available spot2 
Given a valid spot
When I travel to "2023-11-25 09:11:00"
And I am on the spots page
Then I should see "Available"

Scenario: show map on the home page
Given I am on the spots page
Then I should view element "indexMap"

Scenario: show map on the single spot page
Given a valid spot
When I follow the first "Show" 
Then I should view element "map"
