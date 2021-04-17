# frozen_string_literal: true

require_relative "lib/newegg_scraper_chsbr/version"

Gem::Specification.new do |spec|
  spec.name          = "newegg_scraper_chsbr"
  spec.executables = ['newegg_scraper']
  spec.version       = NeweggScraperChsbr::VERSION
  spec.authors       = ["Lrd134"]
  spec.email         = ["larryc3200@gmail.com"]

  spec.summary       = "Cpu Shopping Data from Newegg"
  spec.description   = "To scrape CPU's off of Newegg and display them nicely."
  spec.homepage      = "https://github.com/Lrd134/aa_phase_1_proj"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  #spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Lrd134/aa_phase_1_proj"
  spec.metadata["changelog_uri"] = "https://github.com/Lrd134/aa_phase_1_proj/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["{bin,lib}/**/*"]

  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem

  spec.add_dependency "nokogiri", "~> 1.11.3"
  spec.add_dependency "open-uri", "~> 0.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
