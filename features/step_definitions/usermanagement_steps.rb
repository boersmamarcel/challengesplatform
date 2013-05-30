When(/^I click on the (?:link|button) with title "(.*?)"$/) do |title|
  click_on(title)
end

Then(/^I should see a link with title "(.*?)"$/) do |title|
  !first("a", :text => title).nil?
end

Then(/^I should not see a link with title "(.*?)"$/) do |title|
  first("a", :text => title).nil?
end

When(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |value, dropdown|
  page.select(value, :from => dropdown)
end

Then(/^user (.*?) should have "(.*?)" as (.*?)$/) do |username, value, column|
  find("td#{column}", text: username).should have_content(value)
end