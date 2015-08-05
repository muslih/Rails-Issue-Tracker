class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?, only: [:show, :edit, :update]

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)

    if @ticket.save
      flash[:success] = "Ticket has been created."
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(ticket_params)
      flash[:success] = "Ticket has been updated."
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  private

    def ticket_params
      params.require(:ticket).permit(:title, :issue_type, :status, :priority,
                                    issues_attributes: [:description])
    end

    def does_user_have_access?
      ticket = Ticket.find(params[:id])
      if !(ticket.user == current_user or ['admin', 'technician'].include? current_user.role)
        redirect_to new_user_session_url
      end
    end
end
