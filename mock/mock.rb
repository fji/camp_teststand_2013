require 'sinatra'

set :port, 80

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
