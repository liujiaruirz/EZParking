module SpotsHelper
    # helper function for calculating time_different(remaining parking time)
    def time_difference(time2leave)
        inputTime = Time.new(time2leave.year, time2leave.month, time2leave.day, time2leave.hour, time2leave.min, time2leave.sec, "-05:00")
        difference = inputTime - Time.now
        if difference < 0
            return 'Available'
        end
    
        differenceInYears = difference.to_i / (60 * 60 * 24 * 30 * 12)
    
        difference -= differenceInYears.to_i * (60 * 60 * 24 * 30 * 12)
    
        differenceInMonths = difference.to_i / (60 * 60 * 24 * 30)
    
        difference -= differenceInMonths.to_i * (60 * 60 * 24 * 30)
    
        differenceInDays = difference.to_i / (60 * 60 * 24)
    
        difference -= differenceInDays.to_i * (60 * 60 * 24)
        
        differenceInHours = difference.to_i / (60 * 60)
    
        difference -= differenceInHours.to_i * (60 * 60)
        
        differenceInMinutes = difference.to_i / 60
    
        difference -= differenceInMinutes.to_i * 60
        
        differenceInSeconds = difference.to_i
    
        out = ''
    
        if differenceInYears > 0
        out += differenceInYears.to_s + " years "
        end
    
        if differenceInMonths > 0
        out += differenceInMonths.to_s + " months "
        end
    
        if differenceInDays > 0
        out += differenceInDays.to_s + " days "
        end
        if differenceInHours > 0
        out += differenceInHours.to_s + " hours "
        end
        if differenceInMinutes > 0
        out += differenceInMinutes.to_s + " mins "
        end
        if differenceInSeconds > 0
        out += differenceInSeconds.to_s + " secs "
        end
        
        return out
    end

    def time_parser(time2leave)
        return time2leave.to_s.chop.chop.chop
    end

    def time_in_sec(time2leave)
        inputTime = Time.new(time2leave.year, time2leave.month, time2leave.day, time2leave.hour, time2leave.min, time2leave.sec, "-05:00")
        return inputTime - Time.now.in_time_zone("Eastern Time (US & Canada)")
    end
end
