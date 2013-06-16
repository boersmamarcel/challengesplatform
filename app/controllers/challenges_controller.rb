class ChallengesController < ApplicationController


  rescue_from 'RoleException::AdminLevelRequired', :with => :redirect_unauthorized_request
  rescue_from 'RoleException::SupervisorLevelRequired', :with => :redirect_unauthorized_request

  # Do not allow regular users to see anything
  # Allow regular users some views
  skip_filter :require_admin, :require_supervisor, :only => [:index, :show, :enroll, :unenroll]

  # Allow supervisors to see even more (they already see everything above)
  skip_filter :require_admin, :only => [:new, :edit, :create, :update, :revoke]

  #challenges are public
  skip_filter :authenticate_user!, :only => [:show]

  # GET /challenges
  def index
    @filter = params[:filter] ||= "all"
    case @filter
      when "upcoming"
        @challenges = Challenge.upcoming.sorted_start_date
      when "running"
        @challenges = Challenge.running.sorted_start_date
      when "past"
        @challenges = Challenge.past.sorted_start_date
      when "enrolled"
        @challenges = current_user.participating_challenges.newest_first
      when "supervising"
        if current_user.is_supervisor?
          @challenges = current_user.supervising_challenges
        else
          redirect_to "/challenges"
        end
      else
        @challenges = Challenge.upcoming_and_running.sorted_start_date
    end
    @challenges = @challenges.visible_for_user(current_user).page(params[:page]).per(6)
  end

  # GET /challenges/1
  def show
    @challenge = Challenge.find(params[:id]).decorate

    if current_user.present?
      redirect_unauthorized_request unless @challenge.visible_for_user?(current_user)

      #if a supervisor visits his own challenge it should see extra options so render the review view
      redirect_to supervisor_review_path if current_user.id == @challenge.supervisor.id 
    else
      #render the public version
      render :guest_challenge unless current_user.present?
    end
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
    params[:commit] == "Submit for Review" || params[:commit] == "Resubmit for Review"
  end

  # POST /challenges
  def create
    @challenge = Challenge.new(params[:challenge])

    if self.submit_for_review?
      @challenge.state = 'pending'
    else
      @challenge.state = 'draft'
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

    if params[:challenge].present?
      image = params[:challenge].delete :image
    end

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


  def revoke
    @challenge = Challenge.find(params[:id])
    raise RoleException::SupervisorLevelRequired.new('Supervisor level required') unless @challenge.supervised_by_user?(current_user)

    @challenge.count += 1
    @challenge.state = "draft"

    if @challenge.save
      sendMessageTemplateToUser(current_user, @challenge.supervisor, "Challenge successfully revoked", "user_mailer/revoked_supervisor", { :challenge => @challenge })
      sendMessageTemplateToGroup(@challenge.participants, current_user, "Challenge has been revoked", "user_mailer/revoked_participants", {:challenge => @challenge })
      redirect_to challenge_path(@challenge) , notice: 'Challenge successfully revoked'
    else
      redirect_to challenge_path(@challenge), alert: "Couldn't revoke challenge"
    end
  end

  def enroll
    @challenge = Challenge.find(params[:id])

    if @challenge.supervisor == current_user
      redirect_to supervisor_review_path, alert: 'You cannot be a participant in your own challenge!'
    elsif @challenge.enroll current_user
      sendMessageTemplateToUser(current_user, @challenge.supervisor, "You have been enrolled!", "user_mailer/enrollment", { :challenge => @challenge })
      redirect_to challenge_path(@challenge), notice: 'Successfully enrolled'
    end
  end

  def unenroll
    @challenge = Challenge.find(params[:id])

    if @challenge.unenroll current_user
      sendMessageTemplateToUser(current_user, @challenge.supervisor, "You have been unenrolled", "user_mailer/unenrollment", { :challenge => @challenge })
      redirect_to challenge_path(@challenge), notice: 'Successfully unenrolled'
    end
  end
end
