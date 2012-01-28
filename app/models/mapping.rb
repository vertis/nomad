require 'net/http'
class Mapping
  include Mongoid::Document
  field :source_path, :type => String
  field :target, :type => String

  embedded_in :domain

  def ok?
    Net::HTTP.get_response(URI.parse(target)).code.to_i == 200
  end
end
