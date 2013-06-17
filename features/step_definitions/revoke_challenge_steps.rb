Then(/^the challenge should have state "(.*?)"$/) do |state|
  find(".alert h1").should have_content(state)
end