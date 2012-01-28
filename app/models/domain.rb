class Domain
  include Mongoid::Document
  field :name, :type => String
  field :catch_all, :type => String

  field :alternative_names, :type => Array
  embeds_many :mappings
  #embeds_many :redirects
  
  referenced_in :user
  references_many :requests, :class_name => 'RequestLog'
end
