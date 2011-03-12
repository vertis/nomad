class Domain
  include Mongoid::Document
  field :name, :type => String
  field :catch_all, :type => String

  embeds_many :redirects
  references_many :requests, :class_name => 'RequestLog'
end
