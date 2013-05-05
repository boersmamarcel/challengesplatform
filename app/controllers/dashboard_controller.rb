class DashboardController < ApplicationController

  def index

    @upcoming_challenges = Challenge.upcoming
  end
end
