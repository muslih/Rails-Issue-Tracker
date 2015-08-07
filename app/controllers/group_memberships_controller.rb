include ActionView::Helpers::TextHelper
class GroupMembershipsController < ApplicationController
  def create
    users = User.find(params[:group_membership][:user_id].reject(&:empty?))
    g = Group.find(params[:group_membership][:group_id])

    users.each do |u|
      u.add_group(g.name)
    end

    flash[:success] = "#{pluralize(users.size, 'user')} #{users.size > 1 ? 'have' : 'has'} been added to group #{g.name}"
    redirect_to '/dashboard/admin/managegroups'
  end
end
