require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it "should belong to ticket" do
    should belong_to(:ticket)
  end

  it "should belong to group" do
    should belong_to(:group)
  end
end
