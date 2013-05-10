class ChallengesController < ApplicationController
  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenges }
    end
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @challenge = Challenge.where("id = ? AND (state = 'approved' OR supervisor_id = ?)", params[:id], current_user.id).first

    redirect_to challenges_path and return if @challenge.nil?

    respond_to do |format|
      format.html { @challenge }# show.html.erb
      format.json { render json: @challenge }
    end
  end

    # GET /challenges/proposal
    # GET /challenges/proposal
    def proposal
        @challenges = Challenge.proposal

        respond_to do |format|
            format.html
            format.json { render json: @challenges}
        end
    end

  # GET /challenges/approved
  # GET /challenges/approved.json
  def approved
      @challenges = Challenge.approved

      respond_to do |format|
          format.html
          format.json { render json: @challenges}
      end
  end

    # GET /challenges/declined
    # GET /challenges/declined
    def declined
        @challenges = Challenge.where("state = 'proposal' AND count > 1")
        respond_to do |format|
            format.html
            format.json { render json: @challenges}
        end
    end

    # GET /challenges/pending
    # GET /challenges/pending
    def pending
        @challenges = Challenge.pending

        respond_to do |format|
            format.html
            format.json { render json: @challenges}
        end
    end

  # GET /challenges/new
  # GET /challenges/new.json
  def new
    @challenge = Challenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge }
    end
  end

  # GET /challenges/1/edit
  def edit
    @challenge = Challenge.find(params[:id])
    # Only allow challenges in certain states to be edited...
    respond_to do |format|
      if Challenge.editable.exists?(@challenge)
        format.html
      else
        # You can't edit this challenge, but you are allowed to view it
        format.html { redirect_to @challenge, alert: 'This challenge can not be edited by you.' } unless Challenge.pending.exists?(@challenge)
        # You can't even view it...
        format.html { redirect_to challenges_path, alert: 'This challenge can not be edited by you.' } if Challenge.pending.exists?(@challenge)
      end
    end
  end

  def submit?
    params[:commit] == "Create Challenge"
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(params[:challenge])

    @challenge.submit = false

    if self.submit?
      @challenge.submit = true
      @challenge.state = 'pending'
    else
      @challenge.state = 'proposal'
    end

    @challenge.count = 1
    @challenge.supervisor = @current_user

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to challenges_path, notice: 'Challenge is pending for review' } if @challenge.submit
        format.html { redirect_to challenges_path, notice: 'Challenge successfully saved' } unless @challenge.submit
        format.json { render json: @challenge, status: :created, location: @challenge }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge.errors, notice: @challenges.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenges/1
  # PUT /challenges/1.json
  def update
    @challenge = Challenge.find(params[:id])
    @challenge.submit = true
    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to challenges_path, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to challenges_url }
      format.json { head :no_content }
    end
  end

  def revoke
    @challenge = Challenge.find(params[:id])
    @challenge.count += 1
    @challenge.state = "proposal"
    
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to declined_challenges_path , notice: 'Challenge successfully revoked' }
        format.json { head :no_content }
      else
        format.html { redirect_to challenges_path,  notice: "Couldn't revoke challenge"}
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def enroll
      @challenge = Challenge.find(params[:id])

      @enrollment = @challenge.enrollments.build
      @enrollment.participant = current_user

      respond_to do |format|
        if @enrollment.save
            format.html{ redirect_to challenge_path(@challenge), notice: 'Successfully enrolled'}
            format.json{ head :no_content}
        else
          format.json { render json: @enrollment.errors, status: :unprocessable_entity }
        end
      end

  end

  def unenroll
    @challenge = Challenge.find(params[:id])
    @enrollment = Enrollment.where('participant_id = ? AND challenge_id = ? ', current_user.id, @challenge.id).first

    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to challenge_path(@challenge), notice: 'Successfully unenrolled' }
      format.json { head :no_content }
    end

  end

end
