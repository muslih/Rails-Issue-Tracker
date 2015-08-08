class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?, except: [:edit, :update]

  def index
    if params[:search] == nil
      @users = User.all.order('last_name ASC')
    elsif params[:search] == ''
      flash[:info] = 'Please enter a search query'
      @users = User.all.order('last_name ASC')
    else
      @users = User.search(params[:search]).order('last_name ASC')
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @roleopts = [['Admin', 'admin'], ['Technician', 'technician'], ['Customer', 'customer']]
    session[:return_to] ||= request.referer
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      flash[:success] = "Information has been updated"
      redirect_to session.delete(:return_to)
    else
      render 'edit'
    end
  end

  private

    def update_params
      if current_user.role == 'admin'
        params.require(:user).permit(:role)
      elsif current_user.id == params[:id]
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmatiom)
      end
    end

    def does_user_have_access?
      if !(['admin', 'technician'].include? current_user.role)
        flash[:warning] = "You do not have access to that page."
        redirect_to '/'
      end
    end
end
