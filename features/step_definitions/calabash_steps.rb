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
	
	uri = URI("http://" + server_adress + ":" + server_port + "/" + orientation)
	
	http = Net::HTTP.new(uri.host, uri.port)
	
	request = Net::HTTP::Post.new(uri.request_uri)
	request.body = device_id
	http.read_timeout = 5
	
	res = http.request(request)
	puts res.body
end




#Step definitions:

Then (/^I rotate the device to (landscape|portrait) via servo$/) do |orientation|
	device_id = ENV['SERVO_SERVER_DEVICE']
	server_adress = ENV['SERVO_SERVER_ADR'] 
	server_port = ENV['SERVO_SERVER_PORT']
	request_servo_rotation(device_id, orientation, server_adress, server_port)
end