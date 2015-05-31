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

  s.add_dependency "email_validator"
  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "simple_form", "~> 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "byebug"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "rspec-rails", '~> 3.2.0'
  s.add_development_dependency "sqlite3"
end
