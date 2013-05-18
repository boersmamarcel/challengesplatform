class DashboardController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
    @supervising_challenges = current_user.supervising_challenges.upcoming_and_running.decorate if current_user.is_supervisor?
    @my_challenges = current_user.participating_challenges.upcoming_and_running.running_first.decorate
    @upcoming_challenges = Challenge.upcoming.decorate - @my_challenges
  end
end
