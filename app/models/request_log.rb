class RequestLog
  include Mongoid::Document

  embedded_in :domain
end
