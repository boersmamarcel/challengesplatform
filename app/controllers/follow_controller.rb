class FollowController < ApplicationController

  # All users can use this feature... Only visitors can't
  skip_filter :require_admin, :require_supervisor

  def follows
    @user = User.find(params[:user_id])
  end
  
  def followers
    @user = User.find(params[:user_id])
  end


  def create
    @followee = User.find(params[:user_id])
    redirect_to profile_user_path(@followee), alert: 'You can not follow yourself' and return if @followee.id == current_user.id
    
    @follow = current_user.followrelations.build(:following_id => @followee.id) 
    respond_to do |format|
      if @follow.save
          format.html {redirect_to profile_user_path(@followee), notice: 'You are now following this user'}
      else
          format.html { redirect_to profile_user_path(@followee), notice: 'Whoops something went wrong'}
      end
    end
  end

  def destroy
     @followee = User.find(params[:user_id])
     @followrelation = Follow.where(:user_id => current_user.id, :following_id => @followee.id).first
      
      @followrelation.destroy

      respond_to do |format|
        format.html {redirect_to profile_user_path(@followee), notice: 'You stopped following this user'}
        format.json { head :no_content}
      end
  end
end
