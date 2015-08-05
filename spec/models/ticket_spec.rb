require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:ticket)).to be_valid
  end

  it "should belong to user" do
    should belong_to(:user)
  end

  it "should have many issues" do
    should have_many(:issues)
  end

  it "is invalid without title" do
    expect(FactoryGirl.build(:ticket, title: nil)).not_to be_valid
  end

  it "is invalid without issue type" do
    expect(FactoryGirl.build(:ticket, issue_type: nil)).not_to be_valid
  end

  it "is invalid without status" do
    expect(FactoryGirl.build(:ticket, issue_type: nil)).not_to be_valid
  end

  it "is invalid without priority" do
    expect(FactoryGirl.build(:ticket, priority: nil)).not_to  be_valid
  end

  it "is valid with valid issue type" do
    expect(FactoryGirl.build(:ticket, issue_type: 'software')).to be_valid
    expect(FactoryGirl.build(:ticket, issue_type: 'equipment')).to be_valid
    expect(FactoryGirl.build(:ticket, issue_type: 'computer')).to be_valid
    expect(FactoryGirl.build(:ticket, issue_type: 'peripheral')).to be_valid
    expect(FactoryGirl.build(:ticket, issue_type: 'network')).to be_valid
  end

  it "is invalid with invalid issue type" do
    expect(FactoryGirl.build(:ticket, issue_type: 'not valid issue type')).not_to be_valid
    expect(FactoryGirl.build(:ticket, issue_type: 12345)).not_to be_valid
  end

  it "is valid with valid status" do
    expect(FactoryGirl.build(:ticket, status: 'open')).to be_valid
    expect(FactoryGirl.build(:ticket, status: 'in progress')).to be_valid
    expect(FactoryGirl.build(:ticket, status: 'pending customer response')).to be_valid
    expect(FactoryGirl.build(:ticket, status: 'contact customer')).to be_valid
    expect(FactoryGirl.build(:ticket, status: 'closed')).to be_valid
  end

  it "is invalid with invalid status" do
    expect(FactoryGirl.build(:ticket, status: 'invalid status')).not_to be_valid
    expect(FactoryGirl.build(:ticket, status: 12345)).not_to be_valid
  end

  it "is valid with valid priority" do
    (1..5).each do |i|
      expect(FactoryGirl.build(:ticket, priority: i)).to be_valid
    end
  end

  it "is invalid with invalid priority" do
    expect(FactoryGirl.build(:ticket, priority: 0)).not_to be_valid
    expect(FactoryGirl.build(:ticket, priority: 6)).not_to be_valid
    expect(FactoryGirl.build(:ticket, priority: 122)).not_to be_valid
    expect(FactoryGirl.build(:ticket, priority: -1)).not_to be_valid
    expect(FactoryGirl.build(:ticket, priority: 'abcdefg')).not_to be_valid
  end
end
