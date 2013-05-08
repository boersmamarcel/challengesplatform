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
  profile_user_path(user.id)
end

Given(/^"(.*?)" is following "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end
