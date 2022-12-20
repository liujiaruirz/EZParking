require 'rails_helper'
require 'support/controller_helpers'
require 'rake'

RSpec.describe "Spots", type: :request do
  # before do
  #   @user = User.create!({
  #       :email => "23c@qq.com",
  #       :password => "123456",
  #       :password_confirmation => "123456"
  #   })

  #   # sign_in @user

  # end
  describe "Create new Spot" do
    it "create 1 new spot" do
      # this will perform a GET request to the /health/index route
      # get "/spots"
      # expect(response.status).to eq(302)
      initial_count = Spot.count
      
      @spot = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      expect(@spot.latitude).to eq(45.0)
      expect(@spot.longitude).to eq(112.34)
      expect(@spot.user).to eq(1)
      expect(@spot.time2leave).to eq("2022-12-19 15:35")
      expect(Spot.count - initial_count).to eq(1)
    end
  end
  describe "Delete new Spot" do
    it "delete a spot" do
      # this will perform a GET request to the /health/index route
      @spot = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      @spot.delete
      expect(Spot.count).to eq(0)
    end

    it "delete all spots" do
      # this will perform a GET request to the /health/index route
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      spot2 = Spot.create!(
        :latitude => 46.0,
        :longitude => 113.34,
        :time2leave => "2022-12-19 16:35",
        :user => 2
      )
      Spot.delete_all
      expect(Spot.count).to eq(0)
    end
  end

  describe "change spot" do
    it "change latitude of spot" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      spot1.latitude = 46.01
      expect(spot1.latitude).to eq(46.01)
    end
    it "change longitude of spot" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      spot1.longitude = 116
      expect(spot1.longitude).to eq(116)
    end
    it "change time2leave of spot" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1
      )
      spot1.time2leave = "2022-12-29 15:35"
      expect(spot1.time2leave).to eq("2022-12-29 15:35")
    end
    it "add going" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1,
        :going => 0
      )
      expect(spot1.going).to eq(0)
      spot1.going = 1
      expect(spot1.going).to eq(1)
    end
  end
  describe "auto delete spot" do
    it "deletes expired spots" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1,
        :going => 0
      )
      travel_to Time.zone.local(2022, 12, 21, 01, 04, 44)
      load File.expand_path("../../../lib/tasks/spots.rake", __FILE__)
# make sure you set correct relative path 
      Rake::Task.define_task(:environment)
      # Rake::Task["update_data"].invoke
      Rake::Task["spots:delete_old_spots"].invoke
      expect(Spot.count).to eq(0)
    end
    it "does not deletes new spots" do
      spot1 = Spot.create!(
        :latitude => 45.0,
        :longitude => 112.34,
        :time2leave => "2022-12-19 15:35",
        :user => 1,
        :going => 0
      )
      travel_to Time.zone.local(2022, 12, 19, 15, 04, 44)
      load File.expand_path("../../../lib/tasks/spots.rake", __FILE__)
      # make sure you set correct relative path 
      Rake::Task.define_task(:environment)
      # Rake::Task["update_data"].invoke
      Rake::Task["spots:delete_old_spots"].invoke
      expect(Spot.count).to eq(1)
    end

  end

end
  
