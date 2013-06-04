class DashboardController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
    @supervising_challenges = current_user.supervising_challenges.sorted_start_date.decorate if current_user.is_supervisor?
    @my_challenges = current_user.participating_challenges.upcoming_and_running.sorted_start_date.all
    @upcoming_challenges = Challenge.upcoming.approved.all
    @upcoming_challenges = (@upcoming_challenges - @my_challenges)
    @my_challenges = ChallengeDecorator.decorate_collection(@my_challenges)
    @upcoming_challenges = ChallengeDecorator.decorate_collection(@upcoming_challenges)
  end
end
