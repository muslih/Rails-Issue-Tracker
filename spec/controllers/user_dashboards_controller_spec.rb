require 'rails_helper'

RSpec.describe UserDashboardsController, type: :controller do
  before :each do
    @admin = FactoryGirl.create(:admin)
    @technician = FactoryGirl.create(:technician)
    @customer = FactoryGirl.create(:customer)
  end

  describe "GET admin" do
    it "returns http success when admin is signed in" do
      sign_in @admin
      get :admin

      expect(response).to have_http_status(:success)
    end

    it "returns http success when technician is signed in" do
      sign_in @technician
      get :admin

      expect(response).to have_http_status(:success)
    end

    it "does not return http success when customer is signed in" do
      sign_in @customer
      get :admin

      expect(response).not_to have_http_status(:success)
    end

    it "does not return http success when nobody is signed in" do
      get :admin

      expect(response).not_to have_http_status(:success)
    end
  end

  describe "GET groupmanage" do
    it "returns http success when admin is signed in" do
      sign_in @admin
      get :groupmanage

      expect(response).to have_http_status(:success)
    end

    it "does not return http success when technician is signed in" do
      sign_in @technician
      get :groupmanage

      expect(response).not_to have_http_status(:success)
    end

    it "does not return http success when customer is signed in" do
      sign_in @customer
      get :groupmanage

      expect(response).not_to have_http_status(:success)
    end

    it "does not return http success when nobody is signed in" do
      get :groupmanage

      expect(response).not_to have_http_status(:success)
    end
  end

  describe "GET customer" do
    it "returns http success when admin is signed in" do
      sign_in @admin
      get :customer

      expect(response).to have_http_status(:success)
    end

    it "returns http success when technician is signed in" do
      sign_in @technician
      get :customer

      expect(response).to have_http_status(:success)
    end

    it "returns http success when customer is signed in" do
      sign_in @customer
      get :customer

      expect(response).to have_http_status(:success)
    end

    it "does not return http success when nobody is signed in" do
      get :customer

      expect(response).not_to have_http_status(:success)
    end
  end
end
