$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "giveaways/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "giveaways"
  s.version     = Giveaways::VERSION
  s.authors     = ["robodisco"]
  s.email       = ["adamsubscribe@googlemail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Giveaways."
  s.description = "TODO: Description of Giveaways."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
