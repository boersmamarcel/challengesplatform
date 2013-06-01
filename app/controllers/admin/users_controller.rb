class Admin::UsersController < Admin::AdminController
  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id

    # Update from supervisor to non-supervisor?
    if(params[:user][:role] != 1 and @user.is_supervisor?)
      # Move all challenges supervised by this user to another user (the default sciencechallenges user)
      Challenge.supervised_by_user(@user).each do |challenge|
        challenge.supervisor_id = 1
        challenge.save
      end
    end

    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.role = params[:user][:role]
    @user.active = params[:user][:notify_by_email]
    @user.notify_by_email = params[:user][:notify_by_email]
    @user.save

    redirect_to admin_usermanagement_index_path
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    
    if(@user.is_supervisor?)
      # Move all challenges supervised by this user to another user (the default sciencechallenges user)
      Challenge.supervised_by_user(@user).each do |challenge|
        challenge.supervisor_id = 1
        challenge.save
      end
    end

    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end