class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?

  def show
    @user = User.find(params[:id])
  end

  private

    def does_user_have_access?
      if !(['admin', 'technician'].include? current_user.role)
        flash[:warning] = "You do not have access to that page."
        redirect_to '/'
      end
    end
end
