When(/^I visit the "(.*?)" page$/) do |pageName|
	pending # express the regexp above with the code you wish you had

	case pageName
	when "login"

	when "register"

	else
		print("Invalid path");
	end
end

When(/^I fill in email with "(.*?)" and password with "(.*?)"$/) do |email, password|
	pending # express the regexp above with the code you wish you had
end

Then(/^I should see the "(.*?)" page$/) do |pageName|
	pending # express the regexp above with the code you wish you had
end

Then(/^see the "(.*?)" button$/) do |buttonID|
	pending # express the regexp above with the code you wish you had
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
	pending # express the regexp above with the code you wish you had
end

