When(/^I open the review challenge page for challenge with id "(.*?)"$/) do |id|
  visit admin_review_path(Challenge.find(id))
end

Given(/^I am on the review challenge page for challenge with id "(.*?)"$/) do |id|
  step "I open the review challenge page for challenge with id \"#{id}\""
end

Given(/^I fill in comment with "(.*?)"$/) do |comment|
  fill_in :comment, :with => comment
end

