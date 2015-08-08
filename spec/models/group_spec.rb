require 'rails_helper'
RSpec.describe Group, type: :model do
  it "should have many group memeberships" do
    should have_many(:group_memberships)
  end

  it "should have many users" do
    should have_many(:users)
  end

  it "should have many assignments" do
    should have_many(:assignments)
  end

  it "should have many tickets" do
    should have_many(:tickets)
  end
end
