require 'rails_helper'

RSpec.describe PassthroughController, type: :controller do
  before :each do
    @admin = FactoryGirl.create(:admin)
    @technician = FactoryGirl.create(:technician)
    @customer = FactoryGirl.create(:customer)
  end

  describe "GET #index" do
    it "redirects to dashboard when admin is signed in" do
      sign_in @admin
      get :index

      expect(response).to redirect_to dashboard_path
    end

    it "redirects to dashboard when technician is signed in" do
      sign_in @technician
      get :index

      expect(response).to redirect_to dashboard_path
    end

    it "redirects to mytickets when customer is signed in" do
      sign_in @customer
      get :index

      expect(response).to redirect_to mytickets_path
    end
  end
end
