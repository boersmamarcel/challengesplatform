class ChallengeDecorator < Draper::Decorator
  include Sprockets::Helpers::RailsHelper
  delegate_all

  def value
    title
  end

  def url
    Rails.application.routes.url_helpers.challenge_path(id)
  end

  def sub
    "By; #{supervisor.decorate.fullname}"
  end

  def img
    ActionController::Base.helpers.image_path("fav32.png")
  end

  def as_json(options={})
    super(
      options.merge(
        :root => false, 
        :only => [], 
        :methods => [:url, :value, :sub, :img]
      )
    )
  end

  def implied_state
    if declined?
      "declined"
    else
      state
    end
  end

  def human_readable_start_date
    if start_date.present?
      start_date.strftime("%d-%m-%Y")
    else
      "TBC."
    end
  end

  def human_readable_end_date
    if end_date.present?
      end_date.strftime("%d-%m-%Y")
    else
      "TBC."
    end
  end

  def current_user_enrolled?
    participants.exists? h.current_user
  end

  def warn_current_user_enrollment?
    upcoming? && !current_user_enrolled? && days_till_start < 10
  end

  def location
    if object.location.blank?
      "TBA"
    else
      object.location
    end
  end

  def supervisor
    if object.supervisor.present?
      object.supervisor.decorate
    else
      nil
    end
  end

  def day_of_week
    if start_date.present?
      start_date.strftime("%A")
    else
      "TBC"
    end
  end

  def from_till
    ("From " + h.content_tag(:span, human_readable_start_date, :id => 'start_date') + " till " +  h.content_tag(:span, human_readable_end_date, :id => 'end_date')).html_safe
  end

  def human_date_string
    (day_of_week.pluralize + " " + from_till.downcase).html_safe
  end

  def days_total
    if start_date.present? && end_date.present?
      startd = start_date.to_date
      endd = end_date.to_date
      (endd - startd).to_i
    end
  end

  def days_till_end
    if start_date.present? && end_date.present? && running?
      today = Date.today
      endd = end_date.to_date
      (endd - today).to_i
    else
      0
    end
  end

  def days_till_start
    if start_date.present? && end_date.present? && upcoming?
      today = Date.today
      startd = start_date.to_date
      (startd - today).to_i + 1
    else
      0
    end
  end
  def days_till_enrollment_closes
    days_till_start
  end

  def percentage_date
    if start_date.present? && end_date.present? && running?
      today = Date.today
      startd = start_date.to_date
      endd = end_date.to_date
      ((((today - startd) / (endd - startd)) * 100 ).to_i).to_s + "%"
    elsif start_date.present? && end_date.present? && upcoming?
      "0%"
    else
      "100%"
    end
  end
  
  def activity_text
    h.link_to title, object
  end
end
