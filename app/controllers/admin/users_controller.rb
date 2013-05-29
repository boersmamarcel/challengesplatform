class Admin::UsersController < Admin::AdminController
  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end