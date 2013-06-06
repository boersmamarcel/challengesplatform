When(/^I open the review challenge page for challenge with id "(.*?)"$/) do |id|
  visit admin_review_path(Challenge.find(id))
end

Given(/^I am on the review challenge page for challenge with id "(.*?)"$/) do |id|
  step "I open the review challenge page for challenge with id \"#{id}\""
end

Given(/^I fill in comment with "(.*?)"$/) do |comment|
  fill_in :comment_comment, :with => comment
end

Then(/^the comment "(.*?)" should be green$/) do |comment|
  within(:xpath, "//p[contains(@class, 'text-success')]") do
    page.should have_content(comment)
  end
end

Then(/^the comment "(.*?)" should not be green$/) do |comment|
  within(:xpath, "//p[contains(@class, 'text-success')]") do
    page.should_not have_content(comment)
  end
end

Given(/^I fill in reason with "(.*?)"$/) do |reason|
  fill_in :reason, :with => reason unless reason.blank?
end

Then(/^I should see "(.*?)" in the "(.*?)" list$/) do |title,listid|
    page.find_by_id(listid).should have_content(title)
end
