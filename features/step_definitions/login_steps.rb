Given(/^I am logged in$/) do
	step "I log in with Google \"test@student.utwente.nl\""
end

Given(/^I am not logged in$/) do
	step "I log out"
end

When(/^I visit the "(.*?)" page$/) do |pageName|
	visit getRoute(pageName)
end

def getRoute(name)
	case name
	when "login"
		new_user_session_path
	when "home"
		root_path
	when "logout"
		destroy_user_session_path
	when "registration.form"
		new_user_registration_path
    when "challenge.new"
        new_challenge_path
    when "challenges.pending"
        pending_challenges_path
    when "challenges.approved"
        approved_challenges_path
    when "challenges.declined"
        declined_challenges_path
    when "challenges.proposal"
        proposal_challenges_path
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

When(/^I log out$/) do
	step "I visit the \"logout\" page"
end

Then(/^see the "(.*?)" button$/) do |buttonID|
	find("#" + buttonID).should_not be_nil
end

Then(/^I should see a message with "(.*?)"$/) do |contents|
    page.should have_content(contents)
end

When(/^I log in with Google "(.*?)"$/) do |email|
	google = { :provider => :google_oauth2,
		:uuid     => "1234",
		:google_oauth2 => {
			:name => "Foo", 
			:email => email
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
