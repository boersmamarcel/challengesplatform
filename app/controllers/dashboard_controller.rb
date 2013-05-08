class DashboardController < ApplicationController

  def index
    @upcoming_challenges = Challenge.upcoming
    @supervising_challenges = current_user.supervising_challenges.upcoming_and_running if current_user.is_supervisor? 
    @my_challenges = current_user.participating_challenges.upcoming_and_running.running_first
  end
end
