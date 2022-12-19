# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name
      when /^the spots page$/ then '/spots'
      when /^Show$/ then '/spots/1'
      when /^Edit$/ then '/spots/1/edit'
      when /^Destroy$/ then '/spots/1/destroy'
      when /^logout$/ then '/'
      when /^change password$/ then '/users/edit'
      when /^New Spot$/ then '/spots/new'
      when /^the sign up page$/ then '/users/sign_up'
      when /^the sign in page$/ then '/users/sign_in'
      when /^the edit page$/ then '/users/edit'
      
    #   when /^Update Spot$/ then '/spots/1'  
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
  
      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)
  