require 'net/http'
require 'open-uri'

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


Given /^I am on the Authors Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

Then /^I should see an item "([^\"]*)" at index (\d+)$/ do |label,index|
  index = index.to_i
  element_exists("tableViewCell index:#{index-1}")
  #label_content = query("tableViewCell index:#{index-1} label description")[0]
  #screenshot_and_raise "item has label '#{label_content}' should have label '#{label}'" if(label_content != label)
end

Then /^I change the date on the date picker to "([^\"]*)"$/ do |dateString|
  select_date(dateString)
end


Then (/^I rotate the device to (landscape|portrait)$/) do |orientation|
	device_id = ENV['SERVO_SERVER_DEVICE']
	server_adress = ENV['SERVO_SERVER_ADR'] 
	server_port = ENV['SERVO_SERVER_PORT']
	request_servo_rotation(device_id, orientation, server_adress, server_port)
end