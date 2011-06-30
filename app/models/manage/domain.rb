class Manage::Domain
  include Mongoid::Document
  field :name, :type => String
  field :catch_all, :type => String
  field :alternative_names, :type => Array
end
