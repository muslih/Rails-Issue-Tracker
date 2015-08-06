require 'rails_helper'
require 'pp'

RSpec.describe TicketsController, type: :controller do
  before :each do
    @incorrect_user = FactoryGirl.create(:customer)
    @admin = FactoryGirl.create(:admin)
    @technician = FactoryGirl.create(:technician)
    @customer = FactoryGirl.create(:customer)
    @ticket = FactoryGirl.build(:ticket)
    @ticket.user_id = @customer.id
    @ticket.save
  end

  describe "GET show" do
    it "returns show page when user is logged in" do
      sign_in @customer
      get :show, :id => @ticket.id

      expect(response).to be_success
    end

    it "does not return show page when incorrect user is logged in" do
      sign_in @incorrect_user
      get :show, :id => @ticket.id

      expect(response).not_to be_success
    end

    it "does return show page when admin is logged in" do
      sign_in @admin
      get :show, :id => @ticket.id

      expect(response).to be_success
    end

    it "does return show page when technician is logged in" do
      sign_in @technician
      get :show, :id => @ticket.id

      expect(response).to be_success
    end
      
    it "does not return show page when user is not logged in" do
      get :show, :id => @ticket.id

      expect(response).not_to be_success
    end
  end

  describe "GET new" do
    it "returns http success when user is logged in" do
      sign_in @customer
      get :new

      expect(response).to be_success
    end

    it "does not return http success when no user is logged in" do
      get :new

      expect(response).not_to be_success
    end
  end

  describe "PUT create" do
    let(:attr) do
      { :title => "Test Title",
        :issue_type => "software",
        :status => "open",
        :priority => 1,
        :issues_attributes => [{ :description => "Test description" }] }
    end

    it "creates a new ticket with valid params" do
      sign_in @customer
      put :create, :ticket => attr
      @customer.reload

      expect(@customer.tickets.size).to eq 2
    end

    it "does not create a new ticket with invalid params" do
      sign_in @customer
      attr[:title] = nil
      put :create, :ticket => attr
      @customer.reload

      expect(@customer.tickets.size).to eq 1
    end

    it "does not create a new ticket with no logged in user" do
      put :create, :ticket => attr
      expect(Ticket.count).to eq 1
    end
  end

  describe "GET edit" do
    it "returns http success when user is logged in" do
      sign_in @customer
      get :edit, :id => @ticket.id

      expect(response).to be_success
    end

    it "does not return http success when incorrect user is signed in" do
      sign_in @incorrect_user
      get :edit, :id => @ticket.id

      expect(response).not_to be_success
    end

    it "returns http success when admin is logged in" do
      sign_in @admin
      get :edit, :id => @ticket.id

      expect(response).to be_success
    end

    it "returns http success when technician is logged in" do
      sign_in @technician
      get :edit, :id => @ticket.id

      expect(response).to be_success
    end 

    it "does not return http success when no user is logged in" do
      get :edit, :id => @ticket.id
      expect(response).not_to be_success
    end
  end

  describe "PUT update" do
    let(:attr) do
      { :title => "Test Title",
        :issue_type => "software",
        :status => "open",
        :priority => 5 }
    end

    it "updates ticket when user is logged in" do
      sign_in @customer
      put :update, :id => @ticket.id, :ticket => attr
      @ticket.reload

      expect(@ticket.title).to eq "Test Title"
      expect(response).to redirect_to @ticket
    end

    it "does not update ticket when incorrect user is logged in" do
      sign_in @incorrect_user
      put :update, :id => @ticket.id, :ticket => attr
      @ticket.reload

      expect(@ticket.priority).not_to eq 5
      expect(response).not_to redirect_to @ticket
    end

    it "updates ticket when admin is logged in" do
      sign_in @admin
      put :update, :id => @ticket.id, :ticket => attr
      @ticket.reload

      expect(@ticket.priority).to eq 5
      expect(response).to redirect_to @ticket
    end

    it "updates ticket when technician is logged in" do
      sign_in @technician
      put :update, :id => @ticket.id, :ticket => attr
      @ticket.reload

      expect(@ticket.priority).to eq 5
      expect(response).to redirect_to @ticket
    end

    it "does not update when no user is logged in" do
      title = @ticket.title
      put :update, :id => @ticket.id, :ticket => attr
      @ticket.reload

      expect(@ticket.title).to eq title
      expect(response).not_to be_success
    end
  end
end
