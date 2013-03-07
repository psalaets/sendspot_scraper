# coding: utf-8
lib = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sendspot_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = "sendspot_scraper"
  spec.version       = SendspotScraper::VERSION
  spec.authors       = ["Paul Salaets"]
  spec.email         = ["psalaets@gmail.com"]
  spec.summary       = %q{Screen scrape thesendspot.com}
  spec.description   = %q{Screen scrapes new routes from thesendspot.com}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "1.5.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.13.0"
end
