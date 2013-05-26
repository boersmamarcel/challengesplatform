class ChallengesController < ApplicationController


  rescue_from 'RoleException::AdminLevelRequired', :with => :redirect_unauthorized_request
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :redirect_unauthorized_request

  # Do not allow regular users to see anything
  # Allow regular users some views
  skip_filter :require_admin, :require_supervisor, :only => [:index, :show, :approved, :enroll, :unenroll]

  # Allow supervisors to see even more (they already see everything above)
  skip_filter :require_admin, :only => [:proposal, :pending, :declined, :new, :edit, :create, :update, :revoke]



  # GET /challenges
  def index
    @filter = params[:filter]
    case @filter
      when "upcoming"
        @challenges = Challenge.upcoming.sorted_start_date
      when "past"
        @challenges = Challenge.past.sorted_start_date
      when "mine"
        @challenges = current_user.participating_challenges.sorted_start_date
      else
        @challenges = Challenge.upcoming.sorted_start_date
    end
    @challenges = @challenges.visible_for_user(current_user).page(params[:page]).per(3)
  end

  # GET /challenges/1
  def show
    @challenge = Challenge.find(params[:id]).decorate
    redirect_unauthorized_request unless @challenge.visible_for_user?(current_user)
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

    raise RoleException::SupervisorLevelRequired.new('Supervisor level required') unless @challenge.editable_by_user?(current_user)

    image = params[:challenge].delete :image

    if self.submit_for_review?
      @challenge.state = 'pending'
    end

    if image.present?
      @challenge.image = image
    end

    if @challenge.update_attributes(params[:challenge]) && @challenge.save
      redirect_to @challenge, notice: 'Challenge was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /challenges/1
  def destroy
    @challenge = Challenge.find(params[:id])
    raise RoleException::SupervisorLevelRequired.new('Supervisor level required') unless @challenge.editable_by_user(current_user)

    @challenge.destroy

    redirect_to challenges_url
  end

  def revoke
    @challenge = Challenge.find(params[:id])
    raise RoleException::SupervisorLevelRequired.new('Supervisor level required') unless @challenge.editable_by_user(current_user)

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
