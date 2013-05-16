class ChallengesController < ApplicationController

  # Do not allow regular users to see anything
  # Allow regular users some views
  skip_filter :require_admin, :require_supervisor, :only => [:index, :show, :approved, :enroll, :unenroll]

  # Allow supervisors to see even more (they already see everything above)
  skip_filter :require_admin, :only => [:proposal, :pending, :declined, :new, :edit, :create, :update, :revoke]


  # GET /challenges
  def index
    @challenges = ChallengeDecorator.decorate_collection(Challenge.running_first)
  end

  # GET /challenges/1
  def show
    @challenge = Challenge.find(params[:id]).decorate
    redirect_unauthorized_request unless @challenge.visible_for_user?(current_user)
  end

  # GET /challenges/proposal
  def proposal
    @challenges = Challenge.proposal
  end

  # GET /challenges/approved
  def approved
    @challenges = Challenge.approved
  end

  # GET /challenges/declined
  def declined
    @challenges = Challenge.where("state = 'proposal' AND count > 1")
  end

  # GET /challenges/pending
  def pending
    @challenges = Challenge.pending
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
    @challenge = Challenge.find(params[:id])

    unless @challenge.editable_by_user?(current_user)
      redirect_to @challenge, alert: "You do not have the permissions required to view this page."
    end
  end

  def submit_for_review?
    params[:commit] == "Submit for Review"
  end

  # POST /challenges
  def create
    @challenge = Challenge.new(params[:challenge])

    if self.submit_for_review?
      @challenge.state = 'pending'
    else
      @challenge.state = 'proposal'
    end

    @challenge.count = 1
    @challenge.supervisor = @current_user

    if @challenge.save
      notice = @challenge.pending? ? "Challenge is pending for review" : 'Challenge successfully saved'
      redirect_to challenges_path, notice: notice
    else
      render action: "new"
    end
  end

  # PUT /challenges/1
  def update
    @challenge = Challenge.find(params[:id])

    if self.submit_for_review?
      @challenge.state = 'pending'
    end

    if @challenge.update_attributes(params[:challenge])
      redirect_to challenges_path, notice: 'Challenge was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /challenges/1
  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    redirect_to challenges_url
  end

  def revoke
    @challenge = Challenge.find(params[:id])
    @challenge.count += 1
    @challenge.state = "proposal"

    if @challenge.save
      redirect_to declined_challenges_path , notice: 'Challenge successfully revoked'
    else
      redirect_to challenges_path,  notice: "Couldn't revoke challenge"
    end
  end

  def enroll
    @challenge = Challenge.find(params[:id])

    if @challenge.enroll current_user
      redirect_to challenge_path(@challenge), notice: 'Successfully enrolled'
    end
  end

  def unenroll
    @challenge = Challenge.find(params[:id])

    if @challenge.unenroll current_user
      redirect_to challenge_path(@challenge), notice: 'Successfully unenrolled'
    end
  end
end
