namespace :spots do
  desc "Auto delete spots which were 2 hours past available time"
  task delete_old_spots: :environment do
    # puts "hello"
    Spot.where("time2leave <= ?", [Time.zone.now - 7.hours]).delete_all
    # Spot.where(:time2leave < Time.current - 2.hours).delete_all
  end

end
