module Admin
  class AdminController < ApplicationController
    # Ensures that the user is an administrator
    before_action :authenticate_admin

    # Uses the layout in /app/views/layouts/admin.html.erb
    # to render the admin pages
    layout 'admin/admin'
  end
end
