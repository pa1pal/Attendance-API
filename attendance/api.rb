$:<< File.dirname(File.expand_path(__FILE__))

require 'sinatra'
require 'json'
require 'service/AttendanceService'

get '/users' do
  begin
    code, response = AttendanceService.new().getUsers()
    status code
    content_type :json
    response
  rescue => e
    status 500
    content_type :text
    e.message
  end
end

get '/users/:id' do
  begin
    code, response = AttendanceService.new().getUser(params[:id])
    status code
    content_type :json
    response
  rescue => e
    status 500
    content_type :text
    e.message
  end
end

post '/users' do
  begin
    code, response = AttendanceService.new().post(request.env["rack.input"].read)
    status code
    content_type :json
    response
  rescue => e
    status 500
    content_type :text
    e.message
  end
end
