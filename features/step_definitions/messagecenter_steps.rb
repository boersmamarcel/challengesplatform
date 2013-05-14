Then(/^I should see an? "(.*?)" mailbox icon$/) do |icontype|
  page.should have_css('#mailbox.' + icontype)
end

Given(/^I have read all my messages$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click on the "(.*?)" button$/) do |button|
  find('#' + button.delete(' ')).click
end

Then(/^I should see a modal overlay$/) do
  page.should have_css('.modal')
end

Then(/^I should see a title "(.*?)"$/) do |title|
  page.should have_xpath("//h1", :text => title)
end
