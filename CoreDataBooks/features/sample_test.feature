Feature: Running a test
  As an iOS developer
  I want to have a sample feature file
  So I can begin testing quickly

Scenario: Example steps
  Given my app is running
  And I am on the Authors Screen
  Then I should see a "Add" button
  And I press the "Add" button
  And I should see an item "Title" at index 1
  And I should see an item "Author" at index 2
  Then I touch list item number 1
  And I wait for 1 text field
  Then I rotate the device to landscape via servo
  And I wait
  Then I rotate the device to portrait via servo
  And I wait
  And I should see 1 text field
  And I clear text field number 1
  And I enter "Hitchhiker's Guide to the Galaxy" into text field number 1
  And I press the "Save" button
  And I wait
  Then I touch list item number 2
  And I wait for 1 text field
  And I clear text field number 1
  And I enter "Douglas Adams" into text field number 1
  And I press the "Save" button
  Then I touch list item number 3
  And I wait
  Then I change the date on the date picker to "01/01/1979"
  And I press the "Save" button
  Then I wait for the "Save" button to appear
  Then I press the "Save" button
  And I wait
  Then I rotate the device to landscape via servo
  And I wait
 
  

