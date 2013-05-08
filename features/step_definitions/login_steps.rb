Given(/^I am logged in$/) do
  step "I log in with Google \"test@student.utwente.nl\""
end

Given(/^I am logged in as a participant$/) do
  step "I log in with Google \"participant@student.utwente.nl\""
end

Given(/^I am logged in as a supervisor$/) do
  step "I log in with Google \"test@student.utwente.nl\""
end


Given(/^I am not logged in$/) do
  step "I log out"
end

When(/^I fill in email with "(.*?)" and password with "(.*?)"$/) do |email, password|
  fill_in :user_email, :with => email
  fill_in :user_password, :with => password

  click_button "Sign in"
end

When(/^I log out$/) do
  step "I visit the \"logout\" page"
end

When(/^I log in with Google "(.*?)"$/) do |email|
  google = {
    :provider => :google_oauth2,
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
  default = {
    :provider => :google_oauth2,
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
