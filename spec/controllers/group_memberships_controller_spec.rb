require 'rails_helper'

RSpec.describe GroupMembershipsController, type: :controller do
  before :each do
    @admin = FactoryGirl.create(:admin)
    @technician = FactoryGirl.create(:technician)
    @customer = FactoryGirl.create(:customer)
    groups = %w{software equipment desktop network helpdesk admin}
    groups.each do |group|
      Group.create(name: group)
    end
  end
  describe "PUT create" do
    let(:attr) do
      { user_id: [@technician.id],
        group_id: 2 }
    end

    it "adds technician to groups when admin is signed in" do
      sign_in @admin
      put :create, group_membership: attr
      @technician.reload

      expect(@technician.groups.size).to eq 1
    end

    it "does not add technician when customer is signed in" do
      sign_in @customer
      put :create, group_membership: attr
      @technician.reload

      expect(@technician.groups.size).to eq 0
    end

    it "does not add technician when technician is signed in" do
      sign_in @technician
      put :create, group_membership: attr
      @technician.reload

      expect(@technician.groups.size).to eq 0
    end

    it "does not add technician when nobody is signed in" do
      put :create, group_membership: attr
      @technician.reload

      expect(@technician.groups.size).to eq 0
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @technician.add_group('software')
    end

    it "deletes user from group when admin is signed in" do
      sign_in @admin
      delete :destroy, { id: 1, user_id: @technician.id }
      @technician.reload

      expect(@technician.groups.size).to eq 0
    end

    it "does not delete user from group when technician is signed in" do
      sign_in @technician
      delete :destroy, { id: 1, user_id: @technician.id }
      @technician.reload

      expect(@technician.groups.size).to eq 1
    end

    it "does not delete user from group when customer is signed in" do
      sign_in @customer
      delete :destroy, { id: 1, user_id: @technician.id }
      @technician.reload

      expect(@technician.groups.size).to eq 1
    end

    it "does not delete user from group when nobody is signed in" do
      delete :destroy, { id: 1, user_id: @technician.id }
      @technician.reload

      expect(@technician.groups.size).to eq 1
    end
  end
end
