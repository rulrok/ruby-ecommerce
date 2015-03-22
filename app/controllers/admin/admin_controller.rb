class Admin::AdminController < ApplicationController
  before_action :authenticate_admin # Ensures that the user is an administrator
  layout 'admin/admin' # Uses the layout in /app/views/layouts/admin.html.erb to render the admin pages
end
