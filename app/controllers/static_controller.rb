class StaticController < ApplicationController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor, :only => [:index, :aboutus, :team, :createchallenge, :challengeguidelines, :universities, :companies, :students, :privacy, :termsofservice]

  def index
      @highlited_challenges = Challenge.upcoming_and_running.sorted_start_date.limit(3).decorate
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

  def students
  	render :students
  end

  def termsofservice
  	render :termsofservice
  end

  def privacy
  	render :privacy
  end

end
