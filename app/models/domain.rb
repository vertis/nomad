class Domain
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :catch_all, :type => String

  field :alternative_names, :type => Array
  embeds_many :mappings
  embeds_many :catches, :class_name => "RedirectCatch"
  
  before_save :strip_leading_www_in_name
  validates_presence_of :name, :message => 'Please enter the source domain.'
  validates_format_of :name, :without => /^https?\:\/\//, :message => "Your source domain shouldn't have 'http://' or 'https://' at the start of the url."
  
  validates_presence_of :catch_all, :message => 'Please enter the default redirect target here.'
  validates_format_of :catch_all, :with => /^https?\:\/\//, :message => "Please put either 'http://' or 'https://' at the start of the url."
  
  referenced_in :user
  references_many :requests, :class_name => 'RequestLog'
  
  private
  def strip_leading_www_in_name
    return if name.nil?
    name.gsub!(/^www\./i,'')
  end
  
  def self.by_name(name)
    self.where(:name => name).first
  end
end
