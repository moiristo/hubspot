$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hubspot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hubspot"
  s.version     = Hubspot::VERSION
  s.authors     = ["Reinier de Lange"]
  s.email       = ["r.j.delange@nedforce.nl"]
  s.homepage    = "http://www.nedforce.nl"
  s.summary     = "Integration with the Hubspot API"
  s.description = "Integration with the Hubspot API"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3"

  s.add_development_dependency "sqlite3"
end
