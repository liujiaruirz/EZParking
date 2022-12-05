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
And I fill in "Time2leave" with "2022-11-18 19:27:29"
And I fill in "Latitude" with "51.6"
And I fill in "Longitude" with "-46.3"
And I press "Update Spot"
Then I should see "2022-11-18 19:27:29" after "Time to Leave"
Then I should see "Longitude"
And I should see "51.6" after "Latitude"
And I should see "-46.3" after "Longitude"

#Scenario: destroy spot information
#Given  I am on the spots page
#When I click Destroy
#And I press "OK"


Scenario: add new spot
When I click New Spot
And I fill in "Time2leave" with "2022-12-01 20:23:39"
And I fill in "Latitude" with "35.4"
And I fill in "Longitude" with "52.6"
And I press "Create Spot"
Then I should see "Time to Leave" 
And I should see "2022-12-01 20:23:39"  
And I should see "35.4" after "Latitude"
And I should see "52.6" after "Longitude"


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
