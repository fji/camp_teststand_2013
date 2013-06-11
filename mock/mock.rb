require 'sinatra'

set :port, 8080
set :bind, "192.168.200.116"

post '/landscape' do
	sleep 2
	"Servo no. "+request.body.string+" landscape OK"
end

post '/portrait' do
	#p params 
	#alternative[200,{},"Test123456"]
	sleep 2
	"Servo no. "+request.body.string+" portrait OK"
end
