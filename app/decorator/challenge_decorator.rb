class ChallengeDecorator < Draper::Decorator
  delegate_all
  
  def human_readable_start_date
    object.start_date.strftime("%d-%m-%Y")
  end
  
  def human_readable_end_date
    object.end_date.strftime("%d-%m-%Y")
  end
  
  
end
