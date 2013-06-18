class UserMailer < ActionMailer::Base
  default from: "do-not-reply@sciencechallenges.nl"

  def personal_message(to, subject, message, messageObject, sender)
    @message = message
    @messageObject = messageObject
    @sender = sender.decorate
    mail(:to => to)
  end
end
