require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    @admin = FactoryGirl.create(:admin)
    @technician = FactoryGirl.create(:technician)
    @customer = FactoryGirl.create(:customer)
    groups = %w{software equipment desktop network helpdesk admin}
    groups.each do |group|
      Group.create(name: group)
    end
  end

  describe "GET #index" do
    it "returns http success when admin is logged in" do
      sign_in @admin
      get :index

      expect(response).to have_http_status(:success)
    end

    it "returns http success when technician is logged in" do
      sign_in @technician
      get :index

      expect(response).to have_http_status(:success)
    end

    it "returns http success when admin is logged in" do
      sign_in @customer
      get :index

      expect(response).not_to have_http_status(:success)
    end

    it "returns http success when admin is logged in" do
      get :index

      expect(response).not_to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success when admin is signed in" do
      sign_in @admin
      get :show, id: @customer.id

      expect(response).to have_http_status(:success)
    end

    it "returns http success when technician is signed in" do
      sign_in @technician
      get :show, id: @customer.id

      expect(response).to have_http_status(:success)
    end

    it "does not return http success when customer is signed in" do
      sign_in @customer
      get :show, id: @customer.id

      expect(response).not_to have_http_status(:success)
    end

    it "does not return http success when nobody is signed in" do
      get :show, id: @customer.id

      expect(response).not_to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success when admin accesses user page" do
      sign_in @admin
      get :edit, id: @customer.id

      expect(response).to have_http_status(:success)
    end

    it "does not return http success when tech tries to access user page" do
      sign_in @technician
      get :edit, id: @customer.id

      expect(response).not_to have_http_status(:success)
    end

    it "does not reutrn http success when customer tries to access a different users page" do
      sign_in @customer
      get :edit, id: @admin.id

      expect(response).not_to have_http_status(:success)
    end

    it "returns http success when tech accesses their edit page" do
      sign_in @technician
      get :edit, id: @technician.id

      expect(response).to have_http_status(:success)
    end

    it "returns http success when customer accesses their edit page" do
      sign_in @customer
      get :edit, id: @customer.id

      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    before :each do
      session[:return_to] = '/'
    end

    it "updates technician role to admin when admin updates" do
      sign_in @admin
      put :update, id: @technician.id, user: { role: 'admin' }
      @technician.reload

      expect(@technician.role).to eq 'admin'
    end

    it "does not update role when tech is signed in" do
      sign_in @technician
      put :update, id: @customer.id, user: { role: 'admin' }
      @customer.reload

      expect(@customer.role).to eq 'customer'
    end

    it "does not update role when customer is signed in" do
      sign_in @customer
      put :update, id: @admin.id, user: { role: 'customer' }
      @admin.reload

      expect(@admin.role).to eq 'admin'
    end

    it "does not update role when nobody is signed in" do
      put :update, id: @admin.id, user: { role: 'technician' }
      @admin.reload

      expect(@admin.role).to eq 'admin'
    end

    it "updates users name when user is signed in" do
      sign_in @customer
      put :update, id: @customer.id, user: { :first_name => 'testing' }
      @customer.reload

      expect(@customer.first_name).to eq 'testing'
    end

    it "updates admin name when admin is signed in" do
      sign_in @admin
      put :update, id: @admin.id, user: { first_name: 'testing' }
      @admin.reload

      expect(@admin.first_name).to eq 'testing'
    end

    it "does not update customer first name when admin is signed in" do
      sign_in @admin
      put :update, id: @customer.id, user: { first_name: 'testing' }
      @customer.reload

      expect(@customer.first_name).not_to eq 'testing'
    end

    it "doest not update first name when nobody is signed in" do
      put :update, id: @technician.id, user: { first_name: 'testing' } 
      @technician.reload

      expect(@technician.first_name).not_to eq 'testing'
    end
  end
end
