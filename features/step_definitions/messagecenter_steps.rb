Then(/^I should see an? "(.*?)" mailbox icon$/) do |icontype|
  page.should have_css('#mailbox.' + icontype)
end

Given(/^I have read all my messages$/) do
  Message.all.each do |m|
    m.is_read = true
    m.save
  end
end

When(/^I click on the "(.*?)" button$/) do |button|
  # possible AJAX fixing?
  page.should have_css('#' + button.delete(' '))
  find('#' + button.delete(' ')).click
end

Then(/^I should see a modal overlay$/) do
  page.should have_css('.modal')
end

Then(/^I should see a title "(.*?)"$/) do |title|
  page.should have_xpath("//h1 | //h2 | //h3 | //h4", :text => title)
end
