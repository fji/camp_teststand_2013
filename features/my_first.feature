Feature: Connect feature

  Scenario: As a new user I can connect to a device
    When I press "Suche Geräte"
    Then I see "This device does not have a bluetooth adapter"
