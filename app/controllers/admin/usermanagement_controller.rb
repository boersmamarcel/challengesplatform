class Admin::UsermanagementController < Admin::AdminController
  def index
    # Get an overview of the users
    @users = User.decorate
    render :index
  end
end