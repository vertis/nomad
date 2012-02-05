require 'net/http'
class Mapping
  include Mongoid::Document
  field :source_path, :type => String
  field :target, :type => String

  validates_presence_of :source_path
  validates_presence_of :target
  validates_format_of :source_path, :with => /^\//
  validates_format_of :target, :with => /^https?\:\/\//
  
  embedded_in :domain

  def ok?
    Net::HTTP.get_response(URI.parse(target)).code.to_i == 200
  end
end
