class Redirect
  include Mongoid::Document
  field :old_path, :type => String
  field :target, :type => String

  embedded_in :domain
end
