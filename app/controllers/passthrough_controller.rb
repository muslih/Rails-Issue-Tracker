class PassthroughController < ApplicationController
  def index
    path = case current_user.role
      when 'admin'
        dashboard_admin_path
      when 'technician'
        dashboard_tech_path
      when 'customer'
        dashboard_path
    end

    redirect_to path
  end
end
