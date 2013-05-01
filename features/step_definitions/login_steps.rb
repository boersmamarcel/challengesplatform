When(/^I visit the "(.*?)" page$/) do |pageName|
	visit getRoute(pageName)
end

def getRoute(name)
	case name
	when "login"
      new_user_session_path
	when "home"
      root_path
	else
		print("Invalid route requested (" + name + ")")
	end
end

When(/^I fill in email with "(.*?)" and password with "(.*?)"$/) do |email, password|
    fill_in :user_email, :with => email
    fill_in :user_password, :with => password
    
    click_button "Sign in"
end

Then(/^I should see the "(.*?)" page$/) do |pageName|
  page.should_not be_nil
	find('input#page_identifier').value.should eql pageName 
end

Then(/^see the "(.*?)" button$/) do |buttonID|
	find("#" + buttonID).should_not be_nil
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
    page.should have_content(contents)
end

When(/^I log in with Google$/) do
	google = { :provider => :google_oauth2,
		:uuid     => "1234",
		:google_oauth2 => {
			:name => "Foo", 
			:email => "test@student.utwente.nl"
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
      :email => "test@student.utwente.nl"
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

Given(/^the following (.+) records?$/) do |factory, table|
  table.hashes.each do |hash|
       FactoryGirl.create(factory, hash)
  end
end
