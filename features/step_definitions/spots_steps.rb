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

# And /^I should see "(.*)" after "(.*)"$/ do |e1, e2|
#     #  ensure that that e1 occurs before e2.
#     #  page.body is the entire content of the page as a string.
#     page.body.index(e1) > page.body.index(e2)
# end

# Then /^I should see "(.*)"$/ do |content|
#     expect(page).to have_content(content)
# end

When /^(?:|I )click (.+)$/ do |page_name|
    visit path_to(page_name)
end