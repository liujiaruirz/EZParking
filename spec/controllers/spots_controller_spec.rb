require 'rails_helper'

RSpec.describe SpotsController, type: :controller do
  
  describe "creates" do
    it "a spot" do
      get :create, {:spot => {:time2leave => 10, :latitude => 40.786162,
                    :longitude => -73.976139}}
      expect(response).to redirect_to spot_path(spot)
      expect(flash[:notice]).to match(/Spot was successfully created./)
      Spot.find_by(:latitude => 40.786162).destroy
    end
  end
  
  describe "updates" do
    it "a spot's time2leave" do
      spot = Spot.create(:time2leave => 10, :latitude => 40.786162,
                          :longitude => -73.976139)
      get :update, {:latitude => 40.786162,
                    :longitude => -73.976139 :movie =>
        {:time2leave => 20}
      }
      
      expect(response).to redirect_to spot_path(spot)
      expect(flash[:notice]).to match(/Spot was successfully updated./)
      spot.destroy
    end
  end
end