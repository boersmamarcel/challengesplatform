class DashboardController < ApplicationController

  def index
    @upcoming_challenges = Challenge.upcoming
    @my_challenges = current_user.enrollments.map{|e| e.challenge}
  end
end
