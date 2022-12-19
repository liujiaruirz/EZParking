require_relative 'controller_marcos'

RSpec.configure do |config|
    config.include Defise::Test::ControllerHelpers, :type => :controller
    config.extend ControllerMacros, :type => controller
end