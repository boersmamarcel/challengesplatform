require 'date'

When(/^I fill in title with "(.*?)" and description with "(.*?)" and start_date with "(.*?)" and end_date with "(.*?)" and lead with "(.*?)" and commitment with "(.*?)" and image with "(.*?)"$/) do | title, description, start_date, end_date, lead, commitment, image |
    fill_in :challenge_title, :with => title
    fill_in :challenge_description, :with => description
    # Uses stringToDate in web_steps.rb
    fill_in :challenge_start_date, :with => stringToDate(start_date) unless start_date == ''
    fill_in :challenge_end_date, :with => stringToDate(end_date) unless end_date == ''
    fill_in :challenge_lead, :with => lead
    fill_in :challenge_commitment, :with => commitment
    if image.present?
        attach_file :challenge_image, File.expand_path("features/test_assets/images/" + image)
    end
end

When(/^I attach the image "(.*?)"$/) do |image|
    attach_file :challenge_image, File.expand_path("features/test_assets/images/" + image)
end

Then(/^I should see a title "(.*?)" and description "(.*?)" and start_date "(.*?)" and end_date "(.*?)"$/) do |title, description, start_date, end_date|
    page.find_by_id("title").should have_content(title)
    page.find_by_id("description").should have_content(description)
    page.find_by_id("start_date").should have_content(start_date)
    page.find_by_id("end_date").should have_content(end_date)
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

When (/^I follow "(.*?)"$/) do |link|
    click_link link
end

Then(/^I should see "(.*?)" in the list$/) do |title|
   page.should have_content(title)
end

Then(/^I should not see "(.*?)" in the list$/) do |title|
  page.should_not have_content(title)
end

When(/^I edit the challenge with id "(.*?)" and a new description "(.*?)"$/) do |id, description|
    visit edit_challenge_path(id)
    fill_in :challenge_description, :with => description
end


Then(/^I should see a submission count of "(.*?)"$/) do |count|
    within("div#submission_count").should have_content(count)
end

When(/^I open the challenge with id "(.*?)"$/) do |id|
    visit challenge_path(id)
end

Then(/^I should see a (button|link) "(.*?)"$/) do |type, button|
   page.should have_selector(:link_or_button, button)
end

When(/^I visit the edit challenge "(.*?)" page$/) do |id|
    visit edit_challenge_path(id)
end
