require 'pp'
class Admin::ReviewController < Admin::AdminController
  
  def index
    # Get all pending for review challenges
    @challenges = Challenge.pending.decorate
  end
  
  def show
    @challenge = Challenge.pending.where(:id => params[:id]).first
    pp @challenge
    if @challenge.present?
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
    
  end
  
end
