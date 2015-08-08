include ActionView::Helpers::TextHelper
class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :does_user_have_access?

  def create
    users = User.find(params[:group_membership][:user_id].reject(&:empty?))
    g = Group.find(params[:group_membership][:group_id])

    users.each do |u|
      u.add_group(g.name)
    end

    flash[:success] = "#{pluralize(users.size, 'user')} #{users.size > 1 ? 'have' : 'has'} been added to group #{g.name}"
    redirect_to '/dashboard/admin/managegroups'
  end

  def destroy
    group = Group.find(params[:id])
    if group.users.delete(params[:user_id])
      flash[:success] = "User has been removed from group."
    else
      flash[:danger] = "Couldn't remove user from group."
    end
    redirect_to '/dashboard/admin/managegroups'
  end

  private

    def does_user_have_access?
      if current_user.role != 'admin'
        flash[:warning] = 'You do not have access to that page'
        redirect_to '/dashboard'
      end
    end
end
