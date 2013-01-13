class Domain
  include Mongoid::Document
  field :name, :type => String

  embeds_many :redirects
end
