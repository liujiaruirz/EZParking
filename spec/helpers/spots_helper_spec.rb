require 'rails_helper'
require 'date'


RSpec.describe SpotsHelper, type: :helper do
    describe "positive result" do
        it "returns the number of minutes and seconds" do
            spot_time = Time.zone.local(2022,11,23,4,5,6)
            travel_to Time.zone.local(2022, 11, 23, 4, 6, 6)
            expect(time_difference(spot_time)).to eq("1 mins") 
            
        end
    end
end