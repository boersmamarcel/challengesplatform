class Supervisor::ReviewController < ApplicationController

  #supervisors should be able to call these functions
  skip_filter :require_admin, :only => [:show]

  def show
    @challenge = Challenge.find_by_id!(params[:id]).decorate
    @new_comment = @challenge.comments.new
    @challenge.reload
    render :show
    redirect_unauthorized_request unless @challenge.visible_for_user?(current_user)
  end
end
