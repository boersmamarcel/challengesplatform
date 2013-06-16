class Admin::ReviewController < Admin::AdminController
  
  def index
    # Get all pending for review challenges
    @challenges = Challenge.pending.decorate
    @draft_challenges = Challenge.draft.decorate
    @declined_challenges = Challenge.declined.decorate
  end
  
  def show
    begin
      @challenge = Challenge.pending.find_by_id!(params[:id]).decorate
      @new_comment = @challenge.comments.new
      @challenge.reload
      render :show
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_review_index_path, :alert => "This challenge can't be reviewed"
    end
  end
  

  def edit
    @challenge = Challenge.find(params[:id])
    @url = admin_review_path(@challenge)

    unless @challenge.editable_by_user?(current_user)
      redirect_to @challenge, alert: "You do not have the permissions required to view this page."
    end
     render 'challenges/edit'
  end

  def submit_for_review?
    params[:commit] == "Submit for Review"
  end


  def update
    @challenge = Challenge.pending.find(params[:id])

    if self.submit_for_review?
      @challenge.state = 'pending'
    end

    if @challenge.update_attributes(params[:challenge])

      redirect_to admin_review_path(@challenge), notice: 'Challenge was successfully updated.'
    else
      render action: "edit"
    end
  end


  def approve
      @challenge = Challenge.pending.find(params[:id])
      @challenge.state = 'approved'

      if @challenge.save
        flash[:notice] = "Challenge is successfully approved"
        sendMessageTemplateToUser(@challenge.supervisor, current_user, "Challenge approved", "user_mailer/challenge_approved", { :challenge => @challenge })
        redirect_to challenge_path(@challenge)
      else
        flash[:notice] = "Something went wrong please try again"
        redirect_to admin_review_path(@challenge)
      end
  end


  def decline
    @comment = Comment.new(:comment => params[:reason], :user_id => current_user.id)
    @challenge =Challenge.pending.find(params[:id])

    @comment.challenge =  @challenge
    @challenge.decline

    if @comment.save && @challenge.save
      notice = "Challenge successfully declined"
      sendMessageTemplateToUser(@challenge.supervisor, current_user, "Challenge declined", "user_mailer/challenge_declined", { :challenge => @challenge })
      redirect_to admin_review_index_path, :alert => notice
    else
      redirect_to admin_review_path(@comment.challenge.id), :alert => 'Challenge can not be declined without comments'
    end
  end
  

  
end
