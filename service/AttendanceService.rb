require 'model/Attendance'
require 'json'

class AttendanceService
  attr_accessor :userObj

  DB_ERROR_MESSAGE = '{ "database" : "not able to connect to db" }'

  def initialize()
    begin
      @userObj = Attendance.new()
    rescue Exception => e
      raise DB_ERROR_MESSAGE
    end
  end

  def post(jsonString)
    if false != @userObj.from_json!(jsonString)
      response = @userObj.save()
      if false != response
        return 201, response.to_json
      end
    end
    return 400
  end

  def getUsers()
    response = @userObj.getList()
    return 200, response.to_json
  end

  def getUser(id)
    response = @userObj.get(id)
    if true == response.nil?
      return 404
    else
      return 200, response.to_json
    end
  end

end