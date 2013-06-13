Feature: Running a test
  As a TV Movie user
  I want to switch through all screens

Scenario: Example steps
  Given the app is running
  And I wait to see "Highlights"
  And I swipe right on the carousel
  And I swipe right on the carousel
  And I swipe right on the carousel
  And I wait
  And I touch the "Übersicht" tabBarButton
  And I touch list item number 3
  Then I should see the detail screen
  And I wait
  Then I touch the close button on the detail screen
  And I wait
  And I touch the "Programm" tabBarButton
  And I wait
  And I scroll down on the program screen
  And I scroll right on the program screen
  And I rotate device left
  And I scroll right on the program screen
  And I rotate device right
  And I scroll right on the program screen
  And I wait
  And I touch the "Merkzettel" tabBarButton
  And I wait and wait
  And I touch the "Einstellungen" tabBarButton
  And I wait and wait
 
  

