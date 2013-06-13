Feature: View landscape
  In order to get rid of useless buttons
  the user should be able to rotate to landscape
  so that the button disappears
  
  Scenario: go to image in landscape mode
    Given I rotate the device to portrait via servo
    And I wait for a second
    Then I should see "Red Balloon"
    When I press "Red Balloon"
    And I wait for the view with id "image" to appear
    Then I should see "Don't click me!"
    And I press "Don't click me!"
    When I rotate the device to landscape via servo
    And I wait for a second
    Then I should not see "Don't click me!"
    