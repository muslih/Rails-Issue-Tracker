require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:customer)).to be_valid
    expect(FactoryGirl.create(:technician)).to be_valid
    expect(FactoryGirl.create(:admin)).to be_valid
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
    expect(FactoryGirl.build(:user, role: nil)).not_to be_valid
  end

  it "is valid with valid user types" do
    expect(FactoryGirl.build(:user, role: 'customer')).to be_valid
    expect(FactoryGirl.build(:user, role: 'technician')).to be_valid
    expect(FactoryGirl.build(:user, role: 'admin')).to be_valid
  end

  it "is invalid with invalid user types" do
    expect(FactoryGirl.build(:user, role: 'not a valid user type')).not_to be_valid
    expect(FactoryGirl.build(:user, role: 1234)).not_to be_valid
  end
end
