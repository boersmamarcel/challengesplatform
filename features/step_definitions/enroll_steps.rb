Then(/^I should not see button "(.*?)"$/) do |button|
  page.should_not have_selector(:link_or_button, button)
end

Given(/^user "(.*?)" is enrolled in challenge "(.*?)"$/) do |user_email, challenge_id|
  user = User.find_by_email(user_email)
  challenge = Challenge.find(challenge_id)
  challenge.participants << user
end

Given(/^user "(.*?)" is enrolled in challenge with title "(.*?)"$/) do |user_email, challenge_title|
  user = User.find_by_email(user_email)
  challenge = Challenge.find_by_title(challenge_title)
  challenge.participants << user
end

Given(/^I am enrolled in challenge with title "(.*?)"$/) do |challenge_title|
  user = User.find_by_email("participant@student.utwente.nl")
  challenge = Challenge.find_by_title(challenge_title)
  challenge.participants << user
end

Given(/^I am enrolled in challenge "(.*?)"$/) do |challenge_id|
  user = User.find_by_email("participant@student.utwente.nl")
  challenge = Challenge.find(challenge_id)
  challenge.participants << user
end

Then(/^I should see a title "(.*?)" and start_date "(.*?)" and end_date "(.*?)" in the list$/) do |title, start_date, end_date|
  start_date = (Date.today + 7).strftime("%d-%m-%Y") if start_date == "next week"
  page.should have_content(title)
  page.should have_content(start_date)
  page.should have_content(end_date)
end

Then(/^I should see a title "(.*?)" and description "(.*?)" and start_date "(.*?)" and end_date "(.*?)" in the list$/) do |title, description, start_date, end_date|
  page.should have_content(title)
  page.should have_content(description)
  page.should have_content(start_date)
  page.should have_content(end_date)
end

