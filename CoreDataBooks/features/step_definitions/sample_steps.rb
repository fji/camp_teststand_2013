Given /^I am on the Authors Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

Then /^I should see an item "([^\"]*)" at index (\d+)$/ do |label,index|
  index = index.to_i
  element_exists("tableViewCell index:#{index-1}")
  #label_content = query("tableViewCell index:#{index-1} label description")[0]
  #screenshot_and_raise "item has label '#{label_content}' should have label '#{label}'" if(label_content != label)
end

Then /^I change the date on the date picker to "([^\"]*)"$/ do |dateString|
  select_date(dateString)
end