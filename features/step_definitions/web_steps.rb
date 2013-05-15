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
  when "challenges.index"
    challenges_path
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
  when "admin/review.index"
    admin_review_index_path
  else
    print("Invalid route requested (" + name + ")")
  end
end

def getRouteWithUser(name, user)
  case name 
  when "user.edit"
    edit_user_registration_path(user)
  else
    print("Invalid route requested (" + name + ")")
  end
end

When(/^I visit the "(.*?)" page for user "(.*?)"$/) do |page, email|
  user = User.where(:email => email).first
  
  visit getRouteWithUser(page,user)

end

Then(/^I should see the "(.*?)" button$/) do |buttonID|
  find("#" + buttonID).should_not be_nil
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
  page.should have_content(contents)
end

Then(/^I should see the "(.*?)" page$/) do |pageName|
  page.should_not be_nil
  find('input#page_identifier').value.should eql pageName
end

Then(/^I should see "(.*?)" in list "(.*?)"$/) do |text, section|
  within(:xpath, "//ul[@id='#{css_case(section)}']") do
    page.should have_content(text)
  end
end

Then(/^I should not see "(.*?)" in list "(.*?)"$/) do |text, section|
  within(:xpath, "//ul[@id='#{css_case(section)}']") do
    page.should_not have_content(text)
  end
end

Then(/^I should see a "(.*?)" field in the form$/) do |fieldName|
  page.should have_xpath('//input[@name="{fieldName}"] | //textarea[@name="{fieldName}"] | //select[@name="{fieldName}"]')
end

def css_case(str)
  str.squish.underscore.downcase.tr(" ","_")
end

def interpret_dates(hash)
  # Interpret dates
  hash.each do |key, value|
    if key.include?("date")
      hash[key] = case value
      when 'today' then
        Date.today
      when 'tomorrow' then
        Date.tomorrow
      when 'next month' then
        Date.today >> 1
      when 'last month' then
        Date.today << 1
      when 'last week' then
        Date.today - 7
      when 'next week' then
        Date.today + 7
      when 'last year' then
        Date.today + 365
      when 'next year' then
        Date.today - 365
      else
        value
      end
    end
  end
end

Given(/^the following (.+) records?$/) do |factory, table|
  table.hashes.each do |hash|
    interpret_dates(hash)
    FactoryGirl.create(factory, hash)
  end
end
