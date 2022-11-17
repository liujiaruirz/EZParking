require 'rails_helper'
RSpec.describe SpotsHelper, type: :helper do
    let!(:item) { Item.create(:item, name: "Milk", expiration_date: 
Time.current + 3.days) }
    described "#expired?" do
        it "return false if item is not expired and true if item is expired" do
            expect(item.expired?).to eq(false)
            travel 5.day    
            expect(item.expired?).to eq(true)
        end
    end
end