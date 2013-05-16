class ChallengeDecorator < Draper::Decorator
  delegate_all

  def human_readable_start_date
    object.start_date.strftime("%d-%m-%Y")
  end

  def human_readable_end_date
    object.end_date.strftime("%d-%m-%Y")
  end

  def current_user_enrolled?
    object.participants.exists? h.current_user
  end

  def warn_current_user_enrollment?
    object.upcoming? && !current_user_enrolled? && days_till_start < 10
  end

  def human_date_string
    "Every " + object.start_date.strftime("%A").downcase + " from " + human_readable_start_date + " till " + human_readable_end_date
  end
  def synopsis
    h.truncate(h.strip_tags(h.markdown(object.description)), :length => 120, :separator => ' ')
  end

  def days_total
    startd = object.start_date.to_date
    endd = object.end_date.to_date
    (endd - startd).to_i
  end

  def days_till_end
    if object.running?
      today = Date.today
      endd = object.end_date.to_date
      (endd - today).to_i
    else
      0
    end
  end

  def days_till_start
    if object.upcoming?
      today = Date.today
      startd = object.start_date.to_date
      (startd - today).to_i
    else
      0
    end
  end
  def days_till_enrollment_closes
    days_till_start
  end

  def percentage_date
    if object.running?
      today = Date.today
      startd = object.start_date.to_date
      endd = object.end_date.to_date
      ((((today - startd) / (endd - startd)) * 100 ).to_i).to_s + "%"
    elsif object.upcoming?
      "0%"
    else
      "100%"
    end
  end
end
