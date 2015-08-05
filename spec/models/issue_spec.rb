require 'rails_helper'

RSpec.describe Issue, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:issue)).to be_valid
  end

  it "should belong to ticket" do
    should belong_to(:ticket)
  end

  it "is invalid without description" do
    expect(FactoryGirl.build(:issue, description: nil)).not_to be_valid
  end
end
