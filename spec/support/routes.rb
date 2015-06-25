# This will include the routing helpers in the specs so that we can use
# new_giveaway_path etc 
RSpec.configure do |c|
  c.include Giveaways::Engine.routes.url_helpers
end