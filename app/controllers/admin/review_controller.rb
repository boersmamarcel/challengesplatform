class Admin::ReviewController < Admin::AdminController
  
  def index
    # Get all pending for review challenges
    @challenges = Challenge.pending.decorate
  end
  
  def show
    @challenge = Challenge.pending.find_by_id(params[:id]).decorate

    if @challenge.present?
      @new_comment = @challenge.comments.new
      @challenge.reload
      render :show
    else
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
    @challenge = Challenge.find(params[:id])

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
      @challenge = Challenge.find(params[:id])
      @challenge.state = 'approved'

      if @challenge.save
        flash[:notice] = "Challenge is successfully approved"
        redirect_to challenge_path(@challenge)
      else
        flash[:notice] = "Something went wrong please try again"
        redirect_to admin_review_path(@challenge)
      end
  end


  def decline
    @comment = Comment.new(:comment => params[:reason], :user_id => current_user.id)
    @challenge =Challenge.find(params[:id])

    @comment.challenge =  @challenge
    @challenge.to_declined

    if @comment.save && @challenge.save
      notice = "Challenge successfully declined"
      redirect_to admin_review_index_path, :alert => notice
    else
      redirect_to admin_review_path(@comment.challenge.id), :notice => 'Challenge can not be declined without comments'
    end
  end
  
  def comment
    @comment = Comment.new(params[:comment])
    
    @comment.user = current_user
    @comment.challenge = Challenge.find(params[:id])

    if !@comment.save
      notice = "Comments must have at least 3 characters"
      redirect_to admin_review_path(@comment.challenge.id), :alert => notice
    else
      redirect_to admin_review_path(@comment.challenge.id)
    end
    
  end
  
end
