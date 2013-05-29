class Admin::UsersController < Admin::AdminController
  def edit
    @user = User.find(params[:id])

    
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end