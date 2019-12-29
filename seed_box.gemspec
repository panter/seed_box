lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seed_box/version'

Gem::Specification.new do |spec|
  spec.name          = 'seed_box'
  spec.version       = SeedBox::VERSION
  spec.authors       = ['Alexis Reigel']
  spec.email         = ['mail@koffeinfrei.org']

  spec.summary       = %q{Provides omnipotent seeds for rails.}
  spec.description   = %q{Enhances the standard rails seeds and the rake tasks
                          with helper methods to enable omnipotent and easier
                          maintenance of seeds.}
  spec.homepage      = "https://github.com/panter/seed_box"
  spec.license       = "LGPL-3.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '>= 4.2'
  spec.add_runtime_dependency 'activerecord', '>= 4.2'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3'
end
