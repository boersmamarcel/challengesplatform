class Admin::ReviewController < Admin::AdminController
  
  def index
    # Get all pending for review challenges
    @challenges = Challenge.pending.decorate
  end
  
  def show
    @challenge = Challenge.pending.where(:id => params[:id]).first
    if @challenge.present?
      @new_comment = @challenge.comments.new
      @challenge.reload
      render :show
    else
      redirect_to admin_review_index_path, :alert => "This challenge can't be reviewed"
    end
    
  end
  
  def edit
    
  end
  
  def update
    
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
