class UserMailer < ActionMailer::Base
  default from: "do-not-reply@sciencechallenges.nl"

  def personal_message(to, subject, message, messageObject, sender)
    
    attachments.inline['logo.png'] = File.read("#{Rails.root.to_s + '/app/assets/images/logoblack.png'}")
    
    @message = message
    @messageObject = messageObject
    @sender = sender.decorate
    mail(:to => to)
  end
end
