class UserDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?

  def admin
    assignments = Ticket.joins(:assignments).where(assignments: { group_id: current_user.groups.map(&:id) })
    @tickets = assignments.where('status != ?', 'closed').order('priority != 5, created_at ASC')

    @open = Ticket.where('status == ?', 'open')
    @progress = Ticket.where('status == ?', 'in progress')
    @pcr = Ticket.where('status == ?', 'pending customer response')
    @cc = Ticket.where('status == ?', 'contact customer') 
  end

  def groupmanage
    @groups = Group.all
    @groupopts = Group.all.map{|g| [g.name.capitalize, g.id]}
    @useropts = User.where('role == ? || role == ?', 'technician', 'admin').map{|u| [u.email, u.id]}
  end

  def tech
  end

  def customer
    @user = current_user
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
