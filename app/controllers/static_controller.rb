class StaticController < ApplicationController

  skip_filter :authenticate_user!, :require_admin, :require_supervisor, :only => [:index]

  def index
      @highlited_challenges = Challenge.upcoming_and_running.sorted_start_date.limit(3).decorate
      render :index
  end
end
