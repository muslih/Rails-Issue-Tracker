class UserDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?

  def admin
    @tickets = Ticket.where('status != ?', 'closed').order('priority != 5, created_at ASC')

    @open = Ticket.where('status == ?', 'open')
    @progress = Ticket.where('status == ?', 'in progress')
    @pcr = Ticket.where('status == ?', 'pending customer response')
    @cc = Ticket.where('status == ?', 'contact customer') 
  end

  def tech
  end

  def customer
    @tickets = current_user.tickets
  end

  private

    def does_user_have_access?
      if params[:action] == 'tech' and current_user.role == 'customer'
        flash[:warning] = "You do not have access to that page."
        redirect_to '/dashboard'
      elsif params[:action] == 'admin' and current_user.role != 'admin'
        flash[:warning] = "You do not have access to that page."
        redirect_to '/dashboard'
      end
    end
end
