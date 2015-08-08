class PassthroughController < ApplicationController
  def index
    path = case current_user.role
      when 'admin'
        dashboard_path
      when 'technician'
        dashboard_path
      when 'customer'
        mytickets_path
    end

    redirect_to path
  end
end
