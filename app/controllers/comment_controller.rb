class CommentController < ApplicationController
  skip_filter :require_admin, :only => [:create]

  def user_may_add_comment?(challenge)
    current_user.is_admin? || challenge.supervisor.id == current_user.id
  end

  def redirect_path
      if current_user.is_admin?
          admin_review_path(@comment.challenge.id)
      else
          supervisor_review_path(@comment.challenge.id)
      end
  end

  def create
    @comment = Comment.new(:comment => params[:comment][:comment])
    @comment.user = current_user
    @comment.challenge = Challenge.find(params[:comment][:challenge_id])

    raise RoleException::SupervisorLevelRequired.new('Supervisor level is required') unless user_may_add_comment?(@comment.challenge)

    if !@comment.save
      notice = @comment.errors.full_messages.to_sentence
      puts @comment.errors.full_messages

      redirect_to redirect_path(), :alert => notice
    else
      redirect_to redirect_path()
    end
    
  end

end
