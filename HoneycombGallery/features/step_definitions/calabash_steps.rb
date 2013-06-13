require 'calabash-android/calabash_steps'

#Servo Rotation via http
def request_servo_rotation(device_id, orientation, server_adress, server_port)
	server = ENV['SERVO_SERVER_ADR']
	if (server_adress.nil? || server_adress.empty?)
		server_adress = "192.168.200.116"
	end
	server_port = ENV['SERVO_SERVER_PORT']
	if (server_port.nil? || server_port.empty?)
		server_port = "8080"
	end
	
	if (orientation.nil? || orientation.empty?)
		orientation = "landscape"
	end
	
	`curl -X PUT -d #{orientation} http://#{server_adress}:#{server_port}/#{device_id}`
	
	
end




#Step definitions:

Then (/^I rotate the device to (landscape|portrait) via servo$/) do |orientation|
	device_id = ENV['SERVO_SERVER_DEVICE']
	server_adress = ENV['SERVO_SERVER_ADR']
	server_port = ENV['SERVO_SERVER_PORT']
	request_servo_rotation(device_id, orientation, server_adress, server_port)
end