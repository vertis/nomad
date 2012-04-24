class RedirectCatch
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :source_path, :type => String
  
  embedded_in :domain
  embeds_many :hits, :class_name => "RedirectCatchHit"
  
  def touch
    hits.create({})
  end
end
