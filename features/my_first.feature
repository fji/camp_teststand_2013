Feature: Connect feature

  Scenario: As a new user I can connect to a device
    When I press "Suche Ger�te"
    Then I see "This device does not have a bluetooth adapter"
