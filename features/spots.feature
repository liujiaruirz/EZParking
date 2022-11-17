Feature: 

    As an user
    So that I can quickly see available parking spots on the map
    I want to see, edit and destroy spots information


Background: spots data added to database


  Given the following spots exist:
  |id| time2leave | latitude  | longitude  |
  |1 | 2022-11-18 20:30:01    | 40.807346 | -73.960714 |
  |2 | 2022-11-19 20:05:01    | 40.808479 | -73.963412 |
  |3 | 2022-11-20 20:00:01    | 40.804792 | -73.964156 |
  |4 | 2022-11-18 20:20:01    | 40.806054 | -73.961227 |
  |5 | 2022-11-17 20:10:01    | 40.0      | -15.0      |

  Given  I am on the spots page
  Then 5 seed spots should exist


Scenario: show spot detail
When I click Show 
Then I should see "Time to Leave"
Then I should see "Latitude"
Then I should see "Longitude"


Scenario: edit spot detail
When I click Edit 
And I fill in "dt" with "2022-11-17 20:18:01"
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
And I fill in "dt" with "2022-11-25 20:10:05"
And I fill in "Latitude" with "70"
And I fill in "Longitude" with "-25"
And I press "Create Spot"
Then I should see "2022-11-25 20:10:05" after "Time to Leave" 
And I should see "70.0" after "Latitude"
And I should see "-25.0" after "Longitude"


Scenario: add new spot and show address
When I click New Spot
And I fill in "dt" with "2022-11-28 20:17:05"
And I fill in "Latitude" with "40.808479"
And I fill in "Longitude" with "-73.963412"
And I press "Create Spot"
Then I should see "2022-11-28 20:17:05" after "Time to Leave" 
And I should see "40.808479" after "Latitude"
And I should see "-73.963412" after "Longitude"
And I should see "2966 Broadway, New York, NY 10027, US"