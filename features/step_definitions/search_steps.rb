When /^(?:|I )click within "([^"]*)"$/ do |selector|
  find(selector).click
end