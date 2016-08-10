$:<< File.dirname(File.dirname(File.dirname(File.expand_path(__FILE__))))

require 'model/Attendance'
require 'json'

class AttendanceService
  attr_accessor :userObj

  DB_ERROR_MESSAGE = '{ "database" : "not able to connect to db" }'

  def initialize()
    begin
      @userObj = Attendance.new()
    rescue => e
      raise DB_ERROR_MESSAGE
    end
  end

  def post(jsonString)
    begin
      @userObj.from_json!(jsonString)
      @userObj.save()
      return 201, @userObj.to_json
    rescue => e
      return 400, e.message
    end
  end

  def getUsers()
    response = @userObj.getList()
    return 200, response.to_json
  end

  def getUser(id)
    begin
      response = @userObj.get(id)
      return 200, response.to_json
    rescue => e
      return 404, e.message
    end
  end

end
