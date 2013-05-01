Then(/^I should get the message "(.*?)"$/) do |message|
	page.should have_content message
end
