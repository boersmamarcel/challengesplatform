Given(/^"(.*?)" is not following "(.*?)"$/) do |user_email, following_email|
   user = User.find_by_email(user_email)
   following = User.find_by_email(following_email)

   relation = Follow.where('user_id = ? AND following_id = ?', user.id, following.id)

   relation.each do |r|
      r.destroy
   end
end

When(/^I visit the profile of "(.*?)"$/) do |user_email|
  user = User.find_by_email(user_email)
  visit profile_user_path(user)
end

Given(/^"(.*?)" is following "(.*?)"$/) do |user_email, following_email|
  user = User.find_by_email(user_email)
  following = User.find_by_email(following_email)
  Follow.create(:user_id => user.id, :following_id => following.id)
end


Then(/^I should see "(.*?)" in the followed by list$/) do |name|
    within(:xpath, "//div[@class='follows_item']/span[@class='follow_name']/a") do
      page.should have_content(name)
    end
end

Then(/^I should not see "(.*?)" in the followed by list$/) do |name|
  
  begin
    within(:xpath, "//div[@class='follows_item']/span[@class='follow_name']/a") do
      page.should_not have_content(name)
    end
  rescue
    
  end
end

Then(/^I should see "(.*?)" in the follows users$/) do |name|
   within(:xpath, "//div[@class='follows_item']/span[@class='follow_name']/a") do
      page.should have_content(name)
    end
end