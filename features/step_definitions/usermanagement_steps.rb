Then(/^I should see a link with title "(.*?)"$/) do |title|
  !first("a", :title => title).nil?
end

Then(/^I should not see a link with title "(.*?)"$/) do |title|
  first("a", :title => title).nil?
end
