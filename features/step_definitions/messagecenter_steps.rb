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

Then(/^I should see a section title "(.*?)"$/) do |title|
  page.should have_xpath("//h1 | //h2 | //h3 | //h4", :text => title)
end

When(/^I click on the "(.*?)" link$/) do |linktext|
  # page.all(:xpath, "//a", :text => linktext).first.click
  click_link(linktext, match: :first)
end

When(/^I have no messages$/) do
  Message.all.each do |m|
    m.destroy
  end
end

When(/^I send a new message with subject "(.*?)" and contents "(.*?)" for challenge "(.*?)"$/) do |subject, body, challenge|
  page.evaluate_script "composeMessage('challenge', #{challenge})"
  fill_in :subject, :with => subject
  fill_in :body, :with => body
  click_button "Send"
end

When(/^I try to send a message$/) do
  page.evaluate_script "composeMessage('user', 4)"
  fill_in :subject, :with => "A Subject"
  fill_in :body, :with => "Some contents"
  click_button "Send"
end

Then(/^user "(.*?)" should have unread messages$/) do |email|
  assert User.find_by_email(email).received_messages.unread.count > 0
end

Then(/^user "(.*?)" should not have unread messages$/) do |email|
  assert User.find_by_email(email).received_messages.unread.count == 0
end