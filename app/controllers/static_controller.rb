class StaticController < ApplicationController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor, :only => [:index, :aboutus, :team, :createchallenge, :challengeguidelines, :universities, :companies, :press, :privacy, :termsofservice]

  def index
      @highlighted_challenges = Challenge.approved.past_last.limit(3).decorate
      render :index
  end

  def aboutus
  	render :aboutus
  end

  def team
  	render :team
  end

  def createchallenge
  	render :createchallenge
  end

  def challengeguidelines
  	render :challengeguidelines
  end

  def universities
  	render :universities
  end

  def companies
  	render :companies
  end


  def termsofservice
  	render :termsofservice
  end

  def privacy
  	render :privacy
  end

  def press
    render :press
  end
end
