Given /the following spots exist/ do |spots_table|
    spots_table.hashes.each do |spot|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
      Spot.create!(spot) 
    end
    # pending "Fill in this step in movie_steps.rb"
  end

  Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
      User.create!(user) 
    end
    # pending "Fill in this step in movie_steps.rb"
  end
Then /^(.*) seed spots should exist$/ do | n_seeds |
    expect(Spot.count).to eq n_seeds.to_i
end
  
# Then /^(?:|I )should be on (.+)$/ do |page_name|
#     # visit path_to(page_name)
#     expect(page).to have_content(page_name)
# end

Then /^I should see "(.*)" after "(.*)"$/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    page.body.index(e1) > page.body.index(e2)
end
Then /^I travel to "(.*)-(.*)-(.*) (.*):(.*):(.*)"$/ do |year, month, day, hour, minute, second|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  year = year.to_i
  month = month.to_i
  day = day.to_i
  hour = hour.to_i
  minute = minute.to_i
  second = second.to_i
  travel_to DateTime.new(year, month, day, hour, minute, second,'-05:00')
end
# And /^I should see "(.*)" after "(.*)"$/ do |e1, e2|
#     #  ensure that that e1 occurs before e2.
#     #  page.body is the entire content of the page as a string.
#     page.body.index(e1) > page.body.index(e2)
# end

# Then /^I should see "(.*)"$/ do |content|
#     expect(page).to have_content(content)
# end


When /^(?:|I )follow the first "([^"]*)"$/ do |link|
  click_link(link, :match => :first)
end

When /^(?:|I )click (.+)$/ do |page_name|
    visit path_to(page_name)
end

Given /^a valid spot$/ do
  @spot = Spot.create!({
             :latitude => "80",
             :longitude => "40",
             :time2leave => "2023-10-25 09:10:30",
             :going => "0",
             :user => "1"
           })
end

