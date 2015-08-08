class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?, only: [:show, :edit, :update]

  def index
    if params[:search] == ''
      flash[:info] = 'Please enter a search query'
    elsif params[:search] == nil
      params[:search] = ''
    end
    @tickets = Ticket.search(params[:search])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
    @ticket.issues.build
    @typeopts = Group.all.map{|g| [g.name.capitalize, g.name]}
    @typeopts.delete(['Admin', 'admin']) unless current_user.role != 'customer'
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)

    if @ticket.save
      @ticket.add_group('helpdesk')
      flash[:success] = "Ticket has been created."
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @typeopts = Group.all.map{|g| [g.name.capitalize, g.name]}
    @typeopts.delete(['Admin', 'admin']) unless current_user.role != 'customer'
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      @ticket.add_group(@ticket.issue_type)
      flash[:success] = "Ticket has been updated."
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:title, :issue_type, :status, :priority,
                                    issues_attributes: [:description, :user_id])
    end

    def does_user_have_access?
      ticket = Ticket.find(params[:id])
      if !(ticket.user == current_user or ['admin', 'technician'].include? current_user.role)
        flash[:warning] = "You do not have access to that page."
        redirect_to '/'
      end
    end
end
