class CommentController < ApplicationController
  skip_filter :require_admin, :only => [:create]

  def user_may_add_comment?(challenge)
    current_user.is_admin? || challenge.supervisor.id == current_user.id
  end

  def create
    @comment = Comment.new(:comment => params[:comment][:comment])
    @comment.user = current_user
    @comment.challenge = Challenge.find(params[:comment][:challenge_id])

    raise RoleException::SupervisorLevelRequired.new('Supervisor level is required') unless user_may_add_comment?(@comment.challenge)

    if !@comment.save
      notice = "Comments must have at least 3 characters"
      if current_user.is_admin?
        redirect_to admin_review_path(@comment.challenge.id), :alert => notice
      else
        redirect_to supervisor_review_path(@comment.challenge.id), :alert => notice
      end
    else
      if current_user.is_admin?
        redirect_to admin_review_path(@comment.challenge.id)
      else
        redirect_to supervisor_review_path(@comment.challenge.id)
      end
    end
    
  end

end
