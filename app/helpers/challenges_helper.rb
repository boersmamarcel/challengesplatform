module ChallengesHelper
  def enrolled?
    enrolled = false
    return false if current_user.nil?
    current_user.enrollments.each do |e|
      if e.challenge.id == @challenge.id
        enrolled = true
      end
    end
    enrolled
  end

  def state_explanation(challenge)
    case challenge.state
    when "declined"
      "Your challenge submission needs some work! See the <a href='#reviewcomments'>review comments</a> for feedback.".html_safe
    when "approved"
      "Your challenge submission is approved, great job! Students can now see this challenge in the challenges overview"
    when "draft"
      "Your challenge is still a draft. When your ready to submit your challenge for review, click Submit for Review. A ScienceChallenges admin will review your work and get back to you"
    when "pending"
      "Your challenge is pending for review. A admin user will soon review your submission and get back to you. You'll recieve an email as soon as this happens"
    end
  end

  def state_alert_class(challenge)
    case challenge.state
    when "declined"
      "alert-error"
    when "approved"
      "alert-success"
    when "draft"
      "alert-info"
    when "pending"
      "alert-info"
    end
  end

  def state_icon_class(challenge)
    case challenge.state
    when "declined"
      "icon-warning-sign"
    when "approved"
      "icon-check-sign"
    when "draft"
      "icon-info-sign"
    when "pending"
      "icon-info-sign"
    end
  end
end
