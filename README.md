camp_teststand_2013
===================

To start the cucumber test you need to set the configuration for the arduino via environment variables.

Example from shell:

	SERVO_SERVER_ADR="192.168.200.116" SERVO_SERVER_PORT="8080" SERVO_SERVER_DEVICE="2" cucumber
  
Then you can use the following steps in the tests:

	I rotate the device to (landscape|portrait)

