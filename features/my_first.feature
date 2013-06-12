Feature: Connect feature

  Scenario: As a new user I can connect to a device
    When I rotate the device to landscape via servo
    Then I should not see "This device does not have a bluetooth adapter"
    When I rotate the device to portrait via servo
    Then I should not see "This device does not have a bluetooth adapter"
    When I rotate the device to landscape via servo
    Then I should not see "This device does not have a bluetooth adapter"
    When I rotate the device to portrait via servo
    Then I should not see "This device does not have a bluetooth adapter"
