require 'rails_helper'

RSpec.describe Spot do
    context "with 2 or more comments" do
      it "orders them in reverse chronologically" do
        spot = Spot.create!(:latitude => "20")
        
        expect(spot.latitude).to eq(20)
      end
    end
  end
