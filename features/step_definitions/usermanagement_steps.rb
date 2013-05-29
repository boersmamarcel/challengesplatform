When(/^I click on the link with title "(.*?)"$/) do |title|
  click_on(title)
end

Then(/^I should see a link with title "(.*?)"$/) do |title|
  !first("a", :text => title).nil?
end

Then(/^I should not see a link with title "(.*?)"$/) do |title|
  first("a", :text => title).nil?
end
