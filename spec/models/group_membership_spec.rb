require 'rails_helper'

RSpec.describe GroupMembership, type: :model do
  it "should belong to users" do
    should belong_to(:user)
  end

  it "should belong to group" do
    should belong_to(:group)
  end
end
