require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "should have many tickets" do
    should have_many(:tickets)
  end

  it "is invalid without a first name" do
    expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
  end

  it "is invalid without a last name" do
    expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
  end

  it "is invalid without a user type" do
    expect(FactoryGirl.build(:user, user_type: nil)).not_to be_valid
  end

  it "is valid with valid user types" do
    expect(FactoryGirl.build(:user, user_type: 'customer')).to be_valid
    expect(FactoryGirl.build(:user, user_type: 'technician')).to be_valid
    expect(FactoryGirl.build(:user, user_type: 'admin')).to be_valid
  end

  it "is invalid with invalid user types" do
    expect(FactoryGirl.build(:user, user_type: 'not a valid user type')).not_to be_valid
    expect(FactoryGirl.build(:user, user_type: 1234)).not_to be_valid
  end
end
