class Admin::UsersController < Admin::AdminController
  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id

    # Update from supervisor to non-supervisor?
    if(@user.is_supervisor? and (params[:user][:role] % 10) != 1)
      # Move all challenges supervised by this user to another user (the default sciencechallenges user)
      Challenge.supervised_by_user(current_user).each do |challenge|
        challenge.supervisor_id = 1
        challenge.save
      end
    end

    redirect_to admin_usermanagement_index_path
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    
    if(@user.is_supervisor?)
      # Move all challenges supervised by this user to another user (the default sciencechallenges user)
      Challenge.supervised_by_user(current_user).each do |challenge|
        challenge.supervisor_id = 1
        challenge.save
      end
    end

    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end