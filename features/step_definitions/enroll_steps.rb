Then(/^I should not see button "(.*?)"$/) do |button|
  page.should_not have_selector(:link_or_button, button)  
end

Given(/^user "(.*?)" is subscribed to challenge "(.*?)"$/) do |user_email, challenge_id|
  user = User.find_by_email(user_email)
  if !user.nil?
    Enrollment.create!(:user_id => user.id, :challenge_id => challenge_id)
  end
end
