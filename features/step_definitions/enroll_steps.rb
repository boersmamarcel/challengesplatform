Then(/^I should not see button "(.*?)"$/) do |button|
  page.should_not have_selector(:link_or_button, button)  
end

Given(/^user "(.*?)" is subscribed to challenge "(.*?)"$/) do |user_email, challenge_id|
  user = User.find_by_email(user_email)
  if !user.nil?
    Enrollment.create!(:user_id => user.id, :challenge_id => challenge_id)
  end
end

Then(/^I should see a title "(.*?)" and description "(.*?)" and start_date "(.*?)" and end_date "(.*?)" in the list$/) do |title, description, start_date, end_date|
  page.should have_content(title)
  page.should have_content(description)
  page.should have_content(start_date)
  page.should have_content(end_date)
end