Then(/^the page should have content "(.*?)"$/) do |content|
  page.should have_content(content)
end