Then(/^I should see the name "(.*?)" on the profile page$/) do |name|
  within(:xpath, '//div[@class="profile_name"]') do 
    page.should have_content(name)
  end
end

When(/^I fill in firstname with "(.*?)" and lastname with "(.*?)"$/) do |firstname, lastname|
  fill_in :user_firstname, :with => firstname
  fill_in :user_lastname, :with => lastname
end