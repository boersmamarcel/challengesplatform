module Admin::ChallengeReviewHelper
  
  def commentdate(c)
    c.updated_at.strftime("%d-%m-%Y %H:%m")
  end
  
  def new_message_after_last_visit(c)
    (c.challenge.updated_at < c.updated_at)
  end
  
end
