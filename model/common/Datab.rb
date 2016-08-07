$: << File.dirname( __FILE__ )
require 'mongo'

module Datab

  class MONGO
    def initialize()
      Mongo::Logger.logger.level = Logger::WARN # Warning Logs
    end

    def getConnected(_server, _db)
      return Mongo::Client.new(get_options(_server, _db))
    end

    def get_options(server, _db)
      uri = "mongodb://#{server[ 'hosts' ].join(',')}/#{_db}?connectTimeoutMS=5000&serverSelectionTimeoutMS=5000"
      # client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
    end
  end

end
