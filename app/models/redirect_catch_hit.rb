class RedirectCatchHit
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :redirect_catch, :class_name => "RedirectCatch"
end
