# EZParking: Where parking spots are found

## Proposal
### Team Members:
Jerry Liu (jl6007), Siyi Hong (sh4325), Qinghang Hong (qh2249), Camille Chu (yc3749)

### Pain points we are addressing
- Finding a parking spot has become one of the biggest daily challenges for NYC drivers. 
- The lack of information on real-time available parking spots is a key factor in the failure of finding a spot.
- No similar application or community on the market allows users to share such information with each other. 

### What our SaaS does to address the pain points
- When a user is going to leave their parking spot, they can post a thread to notify others of their current location and the estimated time to leave. Corresponding availability will be displayed on the map.
- Users looking for a parking spot in an area will be notified by the app when there is a spot. They can also view the map to find a parking spot that is available or about to become available.
- The app will show the number of drivers that intend to park at an available spot as well as their ETA to the spot so that all drivers can make wise decisions on whether to park here or not.
- Users who provide accurate availability information will be rewarded points, which can be used to view more spots on the map.

### Why is our SaaS unique/different from the solutions in the market?
Parking apps on the market are mostly related to the purchase/reservation of a garage spot. Currently, SpotAngels is the closest mobile app on the market to solving the pain points above. It gathers historical parking data (availability, fees, etc.) from clients and uses machine learning algorithms to infer available spots in selected locations, but the predictions are usually inaccurate. Our application, however, aims to create a community that allows users to share real-time availability regarding specific spots, where the information is based on fact instead of inference.

### YouTube Video
https://youtu.be/yTieByrqsxI

## Iteration 1
## Application Environment:
Rails version             5.2.8.1
Ruby version:             2.6.6-p146 (x86_64-darwin21)
### Instructions/Command lines:
#### To run the product:
1. install and start postgresql ('brew install postgresql' and 'brew services start postgresql' for Mac Users)
2. bundle install
3. rake db:migrate
4. rails server
#### To test the product:
### Heroku Deployment Link:
https://secure-scrubland-29494.herokuapp.com/