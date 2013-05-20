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

  def supervisor
    if object.supervisor.present?
      object.supervisor.decorate
    else
      nil
    end
  end

  def day_of_week
    object.start_date.strftime("%A")
  end

  def from_till
    ("From " + h.content_tag(:span, human_readable_start_date, :id => 'start_date') + " till " +  h.content_tag(:span, human_readable_end_date, :id => 'end_date')).html_safe
  end

  def human_date_string
    ("Every " + day_of_week.downcase + ", " + from_till).html_safe
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
