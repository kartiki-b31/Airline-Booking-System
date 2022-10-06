require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Harry", card:"123456789098", address: "Greek Village", mobile:"9988776592", email:"harrys3@gmail.com") }

  before { subject.save }

  it "name should be present"do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "card should be present"do
    subject.card = nil
    expect(subject).to_not be_valid
  end

  it "address should be present"do
    subject.address = nil
    expect(subject).to_not be_valid
  end

  it "mobile should be present"do
    subject.mobile = nil
    expect(subject).to_not be_valid
  end

  it "email should be present"do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  
  it 'checks user can be updated' do
    subject.update(:email => "lockedin@ncsu.edu")
    expect(User.find_by_email("lockedin@ncsu.edu")).to eq(subject(:email))
  end

  it 'checks user can be destroyed' do
    subject.destroy
    expect(User.count).to eq(0)
  end

end
