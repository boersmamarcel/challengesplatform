When(/^I fill in title with "(.*?)" description with "(.*?)"  and fill in start_date with "(.*?)" and end_date with "(.*?)"$/) do | title, description, start_date, end_date |
    fill_in title_field, :with => title
    fill_in description_field, :with => description
    fill_in start_date_field, :with => start_date
    fill_in end_date_field, :with => end_date
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

Then(/^I should see "(.*?)" in the list$/) do |title|
   within("div#title").should have_content(title)
end

When(/^I edit the challenge with id "(.*?)" and a new description "(.*?)"$/) do |id, description|
    
    visit edit_challenge_path(id)
    fill_in description_field, :with => description
end


Then(/^I should see a submission count of "(.*?)"$/) do |count|
    within("div#submission_count").should have_content(count)
end

When(/^I open the challenge with id "(.*?)"$/) do |id|
    visit challenge_path(id)
end

Then(/^I should see a title "(.*?)" and description "(.*?)" and start_date "(.*?)" and end_date "(.*?)"$/) do |title, description, start_date, end_date|
  
    within("div#title").should have_content(title)
    within("div#description").should have_content(description)
    within("div#start_date").should have_content(start_date)
    within("div#end_date").should have_content(end_date)
    
end

Then(/^I should see a button "(.*?)"$/) do |button|
    page.should have_selector(:link_or_button, button)
end

When(/^I visit the edit challenge "(.*?)" page$/) do |id|
    visit edit_challenge_path(id)
end
