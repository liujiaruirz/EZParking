class ApplicationController < ActionController::Base
    before_action :set_time

    def set_time
        @time = Time.now.in_time_zone("Eastern Time (US & Canada)")
    end
end