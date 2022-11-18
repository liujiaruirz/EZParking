require "application_system_test_case"

class SpotsTest < ApplicationSystemTestCase
  setup do
    @spot = spots(:one)
  end

  test "visiting the index" do
    visit spots_url
    assert_selector "h1", text: "Spots"
  end

  test "creating a Spot" do
    visit spots_url
    click_on "New Spot"

    fill_in "Latitude", with: @spot.latitude
    fill_in "Longitude", with: @spot.longitude
    fill_in "Time2leave", with: @spot.time2leave
    click_on "Create Spot"

    assert_text "Spot was successfully created"
    click_on "Back"
  end

  test "updating a Spot" do
    visit spots_url
    click_on "Edit", match: :first

    fill_in "Latitude", with: @spot.latitude
    fill_in "Longitude", with: @spot.longitude
    fill_in "Time2leave", with: @spot.time2leave
    click_on "Update Spot"

    assert_text "Spot was successfully updated"
    click_on "Back"
  end

  test "destroying a Spot" do
    visit spots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Spot was successfully destroyed"
  end


  # test "add going to arrive" do
  #   visit spots_url
  #   click_on "Show"
  #   click_on "Going", match: :first

  #   assert_text "You successfully add it to your going."
  # end

  
end
