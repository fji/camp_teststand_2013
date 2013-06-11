require 'net/http'
require 'open-uri'


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

Then(/^I rotate the device to portrait$/) do
	
	server = ENV['SERVO_SERVER_ADR']
	if (server.nil? || server.empty?)
		server = "192.168.200.116"
	end
	port = ENV['SERVO_SERVER_PORT']
	if (port.nil? || port.empty?)
		port = "8080"
	end
	uri = URI("http://" + server + ":" + port + "/landscape")
	res = Net::HTTP.post_form(uri, 'servo' => '1')
	puts res.body
  
end

Then(/^I rotate the device to landscape$/) do
	
	server = ENV['SERVO_SERVER_ADR']
	if (server.nil? || server.empty?)
		server = "192.168.200.116"
	end
	port = ENV['SERVO_SERVER_PORT']
	if (port.nil? || port.empty?)
		port = "8080"
	end
	uri = URI("http://" + server + ":" + port + "/landscape")
	
	http = Net::HTTP.new(uri.host, uri.port)
	
	request = Net::HTTP::Post.new(uri.request_uri)
	request.body = '1'
	
	res = http.request(request)
	puts res.body
	  
end



Then /^I rotate the device to "(?:landscape|portrait)"$/ do |orientation|
	contents = open('http://www.example.com') {|io| io.read}
	# or
	contents = URI.parse('http://www.example.com').read
end