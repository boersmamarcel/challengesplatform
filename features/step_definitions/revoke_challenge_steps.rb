Then(/^the challenge should have state "(.*?)"$/) do |state|
  find(".alert h4").should have_content(state)
end