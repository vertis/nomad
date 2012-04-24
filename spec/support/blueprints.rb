#require 'machinist/active_record'
require 'machinist/mongoid'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Domain.blueprint do
  name { "domain#{sn}.test" }
  catch_all { "http://blekko.com" }
end

Mapping.blueprint do
  # Attributes here
end

RequestLog.blueprint do
  # Attributes here
end

User.blueprint do
  # Attributes here
  email { "user#{sn}@example.com" }
  password { "password" }
  password_confirmation { "password" }
end

RedirectCatch.blueprint do
  # Attributes here
end

RedirectCatchHit.blueprint do
  # Attributes here
end
