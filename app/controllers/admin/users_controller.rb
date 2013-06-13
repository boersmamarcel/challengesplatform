class Admin::UsersController < Admin::AdminController
  def transfer_challenges(user)
    Challenge.supervised_by_user(user).each do |challenge|
      challenge.supervisor_id = 1
      challenge.save
    end
  end

  def new
    @user = User.new()
    @user.active = true
    @user.notify_by_email = true
  end

  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    # You can't edit the sciencechallenges user, dummy!
    redirect_to admin_usermanagement_index_path if @user.id.eql? 1

    @url = admin_user_path
  end

  def create
    @user = User.new(:password => Devise.friendly_token)

    if @user.update_attributes(params[:user], as: :admin) and @user.save
      @user.send_reset_password_instructions
      redirect_to admin_usermanagement_index_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    # You can't edit the sciencechallenges user, dummy!
    redirect_to admin_usermanagement_index_path if @user.eql? 1

    # If this user is now a regular user, transfer his/her challenges
    if(params[:user][:role].eql? "0" and not @user.role.eql? "0")
      transfer_challenges(@user)
    end

    if @user.update_attributes(params[:user], as: :admin) and @user.save
      redirect_to admin_usermanagement_index_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path if current_user.id.eql? @user.id
    # You can't edit the sciencechallenges user, dummy!
    redirect_to admin_usermanagement_index_path if @user.id.eql? 1
    
    if(@user.is_supervisor?)
      transfer_challenges(@user)
    end

    @user.destroy

    redirect_to admin_usermanagement_index_path
  end
end