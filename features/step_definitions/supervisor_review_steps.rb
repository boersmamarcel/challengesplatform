Then(/^the page should have content "(.*?)"$/) do |content|
  page.should have_content(content)
end

Then(/^the page should not have content "(.*?)"$/) do |content|
  page.should_not have_content(content)
end