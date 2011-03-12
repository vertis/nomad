class Redirect
  include Mongoid::Document
  field :old_path, :type => String
  field :new_path, :type => String

  embedded_in :domain
end
