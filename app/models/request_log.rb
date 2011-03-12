class RequestLog
  include Mongoid::Document

  referenced_in :domain
end
