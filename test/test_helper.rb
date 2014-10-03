ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def creator
    @creator ||= users(:creator)
  end
  
  def business_partner
    @business_partner ||= users(:business_partner)
  end
  
  def pmo
    @pmo ||= users(:pmo)
  end
end
