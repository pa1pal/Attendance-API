$:<< File.dirname(File.expand_path(__FILE__))

require 'common/Base'
require 'json'
require 'pp'


class Attendance < Base
  ATTENDANCE_DB = 'attendance'
  USERS_COLL = 'users'

  def initialize()
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => ATTENDANCE_DB)
    @collection = client[USERS_COLL]
  end

  def validateSave()
    if isNilOrEmpty(@name) or isNilOrEmpty(@college) or isNilOrEmpty(@username)
      raise 'Validation Error'
    end
  end

  def setname(name)
    @name = name
  end

  def setcollege(college)
    @college = college
  end

  def setusername(username)
    if @collection.find(:username => username).count > 0
      raise "Username is already there"
    end
    @username = username
  end

  def isNilOrEmpty(val)
    return (val.nil? or val.empty?)
  end

  def save()
    validateSave()
    obj = JSON.load(self.to_json)
    return @collection.insert_one(obj)
  end

  def getid(username)
    @collection.find()
  end

  def get(key)
    record = @collection.find(:username => key).first
    raise "User `#{key}' does not exist." if record.nil?
    record
  end

  def getList
    record = []
    @collection.find.each do |doc|
      record.push(doc[:username].to_s)
    end
    record
  end
end
