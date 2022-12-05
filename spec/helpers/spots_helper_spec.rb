require 'rails_helper'
require 'date'


RSpec.describe SpotsHelper, type: :helper do
    describe "positive result with mins" do
        it "returns the number of minutes and seconds" do
            spot_time = DateTime.new(2001,2,3,4,6,7,'-05:00')
            travel_to DateTime.new(2001,2,3,4,5,6,'-05:00')
            expect(time_difference(spot_time)).to eq("1 mins 1 secs ") 
            
        end
    end

    describe "positive result with hrs and mins" do
        it "returns the number of hrs and mins" do
            spot_time = DateTime.new(2001,2,3,5,16,6,'-05:00')
            travel_to DateTime.new(2001,2,3,4,5,6,'-05:00')
            expect(time_difference(spot_time)).to eq("1 hours 11 mins ") 
            
        end
    end

    describe "positive result with hrs and mins and secs" do
        it "returns the number of hrs and mins and secs" do
            spot_time = DateTime.new(2001,2,3,5,16,17,'-05:00')
            travel_to DateTime.new(2001,2,3,4,5,6,'-05:00')
            expect(time_difference(spot_time)).to eq("1 hours 11 mins 11 secs ") 
            
        end
    end

    describe "positive result with hrs and mins and secs 2" do
        it "returns the number of hrs and mins and secs" do
            spot_time = DateTime.new(2001,2,3,5,16,17,'-05:00')
            travel_to DateTime.new(2001,2,3,2,5,6,'-05:00')
            expect(time_difference(spot_time)).to eq("3 hours 11 mins 11 secs ") 
            
        end
    end

    describe "negative result 1" do
        it "returns available" do
            spot_time = DateTime.new(2001,2,3,5,16,17,'-05:00')
            travel_to DateTime.new(2001,2,3,5,17,6,'-05:00')
            expect(time_difference(spot_time)).to eq("Available") 
            
        end
    end
    describe "negative result 2" do
        it "returns available" do
            spot_time = DateTime.new(2001,2,3,5,16,17,'-05:00')
            travel_to DateTime.new(2001,3,3,5,17,6,'-05:00')
            expect(time_difference(spot_time)).to eq("Available")     
        end
    end
end