class UserMailer < ActionMailer::Base
  default from: "do-not-reply@sciencechallenges.nl"

  def personal_message(to, subject, message)
    @message = message
    mail(:to => to)
  end
end
