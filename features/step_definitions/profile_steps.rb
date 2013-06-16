Then(/^I should see the name "(.*?)" on the profile page$/) do |name|
  within(:xpath, '//div[@class="profile_name"]') do
    page.should have_content(name)
  end
end

Then(/^I should see the tagline "(.*?)" on the profile page$/) do |tagline|
  within(:xpath, '//div[@class="profile_tagline"]') do
    page.should have_content(tagline)
  end
end

When(/^I fill in firstname with "(.*?)" and lastname with "(.*?)"$/) do |firstname, lastname|
  fill_in :user_firstname, :with => firstname
  fill_in :user_lastname, :with => lastname
end

When(/^I fill in tagline with "(.*?)"$/) do |tagline|
  fill_in :user_tagline, :with => tagline
end

Then(/^I should see the profile of "(.*?)"$/) do |email|
  user = User.find_by_email(email)
  URI.parse(current_url).path.should == getRoute("user." + user.id.to_s + ".profile")
end
