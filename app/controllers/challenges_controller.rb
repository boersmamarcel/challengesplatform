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
    @challenge = Challenge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge }
    end
  end
    
    # GET /challenges/proposal
    # GET /challenges/proposal
    def proposal
        @challenges = Challenge.where(:state => "proposal")
        
        respond_to do |format|
            format.html
            format.json { render json: @challenges}
        end
    end
    
  # GET /challenges/approved
  # GET /challenges/approved.json
  def approved
      @challenges = Challenge.where(:state => "approved")
      
      respond_to do |format|
          format.html
          format.json { render json: @challenges}
      end
  end
    
    # GET /challenges/declined
    # GET /challenges/declined
    def declined
        @challenges = Challenge.where(:state => "declined")
        
        respond_to do |format|
            format.html
            format.json { render json: @challenges}
        end
    end
    
    # GET /challenges/pending
    # GET /challenges/pending
    def pending
        @challenges = Challenge.where(:state => "pending")
        
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
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(params[:challenge])
    
    # empty = false
    #  params[:challenge].each do |var|
    #    if var.blank?
    #      empty = true
    #    end
    #  end
    #    
    #  redirect_to new_challenge_path(params) and flash[:notice] = "One or more fields are missing" and return if empty
    #    
    #  start_date = DateTime.strptime(params[:challenge][:start_date], '%d-%m-%Y')
    #  end_date = DateTime.strptime(params[:challenge][:end_date], '%d-%m-%Y')
    #  
      
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge is pending for review.' }
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

    respond_to do |format|
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
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
end
