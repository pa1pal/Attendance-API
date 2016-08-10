$:<< File.dirname(File.expand_path(__FILE__))

require 'common/Base'
require 'json'
require 'pp'

class Attendance < Base

  # attr_reader :username, :name, :college,

  ATTENDANCE_DB = 'attendance'
  USERS_COLL = 'users'

  def initialize()
    begin
      @mongoAttendanceDB = Datab::MONGO.new().getConnected({'hosts' => ["127.0.0.1"]}, ATTENDANCE_DB)
      pp @mongoAttendanceDB
    rescue Exception => e
      pp "#{e.message}"
      raise e.message
    end
  end

  def validateSave()
    if true == isNilOrEmpty(@name) && true ==  isNilOrEmpty(@college) && true == isNilOrEmpty(@username)
      return true
    end
    return false
  end

  def setname(name)
    return false if false == isNilOrEmpty(name)
    return false if name.class != String
    @name = name
  end

  def setcollege(college)
    return false if false == isNilOrEmpty(college)
    return false if college.class != String
    @college = college
  end

  def setusername(username)
    begin
      return false if false == isNilOrEmpty(username)
      return false if username.class != String
      #raise ("Username is already there")
      if @mongoAttendanceDB[USERS_COLL].find({:username => username}).count() > 0
        raise "Username is already there"
        # if @mongoAttendanceDB[USERS_COLL].find({"username":username}).count() > 0 => e
      end
      @username = username
    rescue
      #raise '{"Username is already there"}'
      raise 'I am rescued.'
    end
  end

  def isNilOrEmpty(val)
    return false if val.nil? or val.empty?
    return true
  end

  def save()
    begin
      raise if false == self.validateSave()
      obj = JSON.load(self.to_json)
      id = @mongoAttendanceDB[USERS_COLL].insert_one(obj)
      obj[:id] = id.inserted_id.to_s
      # obj[:username] = username.to_s
      return obj
    rescue Exception => e
      pp "save #{e.message}"
    end
    return false
  end

  def getid(username)
    @mongoAttendanceDB[USERS_COLL].find()
  end

  def get(id)
    begin
      record = nil
      raise if true == id.nil?
      #doc = @mongoAttendanceDB[USERS_COLL].find(:_id => BSON::ObjectId.from_string(id.to_s)).each
      doc = @mongoAttendanceDB[USERS_COLL].find({"name":"Sagar"}).first
      #{ |doc|
      #@mongoAttendanceDB[USERS_COLL].find(:_id => BSON::ObjectId.from_string(id.to_s)).each { |doc|
      #@mongoAttendanceDB[USERS_COLL].find("username" : id) { |doc|
      #@doc = @mongoAttendanceDB[USERS_COLL].find({"name":"Sagar"})
        #doc[:username] = doc[:_username].to_s
        #doc.delete("_id")
        record = doc

    rescue Exception => e
      pp "get #{e.message}"
      return record
    end
    record
  end

  def getList
    begin
      record = []
      @mongoAttendanceDB[USERS_COLL].find().each { |doc|
        record.push(doc[:username].to_s)
        }
    rescue Exception => e
      pp "getList #{e.message}"
    end
    record
  end
end