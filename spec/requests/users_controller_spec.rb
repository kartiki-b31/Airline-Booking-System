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
        expect(no_email_user).to_not  be_valid
      end


      # Password validation tests
      it "should require a password" do
        expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).to_not  be_valid
      end

      # Password confirmation tests
      it "should require a matching password confirmation" do
        expect(User.new(@attr.merge(:password_confirmation => "invalid"))).to_not  be_valid
      end
    
      it 'checks user can be updated' do
        @attr.update(:email => "lockout@ncsu.edu")
        expect(User.find_by_email("lockout@ncsu.edu")).to eq(@attr)
      end


      it 'checks user can be destroyed' do
        @attr.destroy
        expect(User.count).to eq(0)
      end
end
  end
