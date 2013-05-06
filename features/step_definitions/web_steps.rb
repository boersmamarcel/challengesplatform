When(/^I visit the "(.*?)" page$/) do |pageName|
  visit getRoute(pageName)
end

def getRoute(name)
  case name
  when "login"
    new_user_session_path
  when "dashboard"
    dashboard_path
  when "home"
    root_path
  when "logout"
    destroy_user_session_path
  when "registration.form"
    new_user_registration_path
  when "challenge.new"
    new_challenge_path
  when "challenges.pending"
    pending_challenges_path
  when "challenges.approved"
    approved_challenges_path
  when "challenges.declined"
    declined_challenges_path
  when "challenges.proposal"
    proposal_challenges_path
  else
    print("Invalid route requested (" + name + ")")
  end
end

Then(/^see the "(.*?)" button$/) do |buttonID|
  find("#" + buttonID).should_not be_nil
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
  page.should have_content(contents)
end

Then(/^I should see the "(.*?)" page$/) do |pageName|
  page.should_not be_nil
  find('input#page_identifier').value.should eql pageName
end

Then(/^I should see "(.*?)" in section "(.*?)"$/) do |text, section|
  within("#"+section.css_case(section)) do
    page.should have_content(text)
  end
end

Then(/^I should not see "(.*?)" in section "(.*?)"$/) do |text, section|
  within("#"+css_case(section)) do
    page.should_not have_content(text)
  end
end

def css_case(str) do
  str.squish.underscore.downcase.tr(" ","_")
end
