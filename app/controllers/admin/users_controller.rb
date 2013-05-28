class Admin::UsersController < Admin::AdminController
  def edit
    @user = User.find(params[:id])

    
  end
end