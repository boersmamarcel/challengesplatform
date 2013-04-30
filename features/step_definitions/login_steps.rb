When(/^I visit the "(.*?)" page$/) do |pageName|
	pending
end

def getRoute(name)
	case name
	when "login"
		return "new_user_session"
	when "home"
		return "root"
	else
		print("Invalid route requested (" + name + ")")
	end
end

When(/^I fill in email with "(.*?)" and password with "(.*?)"$/) do |email, password|
	pending # express the regexp above with the code you wish you had
end

Then(/^I should see the "(.*?)" page$/) do |pageName|
	find('input#page_identifier').value.should eql pageName 
end

Then(/^see the "(.*?)" button$/) do |buttonID|
	find("#" + buttonID).should_not be_nil
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
	pending # express the regexp above with the code you wish you had
end

When(/^I log in with Google$/) do
	google = { :provider => :google_oauth2,
		:uuid     => "1234",
		:google_oauth2 => {
			:name => "Foo", 
			:email => "foobar@example.com" 
		}
	}
	set_omniauth(google)
	visit user_omniauth_authorize_path(:google_oauth2)
end

def set_omniauth(opts = {})
	default = { :provider => :google_oauth2,
		:uuid     => "1234",
		:google_oauth2 => {
			:name => "Foo",
                        :email => "foobar@example.com"
                }
	}

	credentials = default.merge(opts)
	provider = credentials[:provider]
	user_hash = credentials[provider]

	OmniAuth.config.test_mode = true

	OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
			'uid' => credentials[:uuid],
			"info" => {
			"email" => user_hash[:email],
		}
	})
end
