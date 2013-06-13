Feature: View landscape
  In order to get rid of useless buttons
  the user should be able to rotate to landscape
  so that the button disappears
  
  Scenario: go to image in landscape mode
    Given I rotate the device to portrait via servo
    Then I should see the text "Red Balloon"
    When I press the the text "Red Balloon"
    And I wait for view with id "image" to appear
    Then I should see the text "Don't click me!"
    And I press the text "Don't click me!"
    When I rotate the device to landscape via servo
    Then I should not see the text "Don't click me!"
    