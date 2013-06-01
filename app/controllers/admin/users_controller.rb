class Admin::UsersController < Admin::AdminController
  def transfer_challenges(user)
    Challenge.supervised_by_user(user).each do |challenge|
      challenge.supervisor_id = 1
      challenge.save
    end
  end

  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id

    # Update from supervisor to non-supervisor?
    if(@user.role == 1 and not params[:user][:role].eql? "1")
      transfer_challenges(@user)
    end

    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.role = params[:user][:role]
    @user.active = params[:user][:active]
    @user.notify_by_email = params[:user][:notify_by_email]
    @user.save

    redirect_to admin_usermanagement_index_path
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    
    if(@user.is_supervisor?)
      transfer_challenges(@user)
    end

    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end