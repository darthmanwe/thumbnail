# -*- encoding: utf-8 -*-
require File.expand_path('../lib/thumbnail/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christian Hellsten"]
  gem.email         = ["christian@aktagon.com"]
  gem.description   = %q{Ruby thumbnail generator}
  gem.summary       = %q{Ruby thumbnail generator}
  gem.homepage      = ""

#  gem.add_development_dependency "minitest"
#  gem.add_development_dependency "guard-minitest"
  gem.add_development_dependency "ruby-debug"
  gem.add_development_dependency "guard-test"
  gem.add_dependency "hashr"
  gem.add_dependency "smusher"
  gem.add_dependency "open4"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "thumbnail"
  gem.require_paths = ["lib"]
  gem.version       = Thumbnail::VERSION
end
