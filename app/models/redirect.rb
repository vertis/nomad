require 'net/http'
class Redirect
  include Mongoid::Document
  field :old_path, :type => String
  field :target, :type => String

  embedded_in :domain

  def ok?
    Net::HTTP.get_response(URI.parse(target)).code.to_i == 200
  end
end
