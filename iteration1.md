Team 39: EZParking

Members: Jerry Liu (jl6007), Siyi Hong (sh4325), Qinghang Hong (qh2249), Camille Chu (yc3749)

Application Environment:
Rails version             5.2.8.1
Ruby version:             2.6.6-p146 (x86_64-darwin21)

Instructions/Command lines:
To run the product:
0. install and start postgresql ('brew install postgresql' and 'brew services start postgresql' for Mac Users)
1. Run bundle install --without production to make sure all gems are properly installed. 
2. Create the initial database schema:
	bundle exec rake db:migrate
	bundle exec rake db:test:prepare
3. Double check that RSpec is correctly set up by running rake spec
4. Double check that Cucumber is correctly set up by running rake cucumber.

To test the product:

Heroku Deployment Link:
https://secure-scrubland-29494.herokuapp.com/

Github Link:
https://github.com/liujiaruirz/EZParking

