require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
  describe "GET index" do
    before(:each) do
        @attr = { :name => "Example User",
                  :email => "user@example.com",
                  :password => "secret"
                  #:password_confirmation => "secret"
        }
      end

      it "should create a new instance given valid attributes" do
        User.create!(@attr)
      end

      # Email validation tests
      it "should require an email" do
        no_email_user = User.new(@attr.merge(:email => ""))
        no_email_user.should_not be_valid
      end

      # Email validation tests
      it "should require an email" do
        no_email_user = User.new(@attr.merge(:email => ""))
        no_email_user.should_not be_valid
      end

      # Password validation tests
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
      end

      # Password confirmation tests
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
      end
end
  end
