# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "xcoder-testflight"
  s.version     = 0.1
  s.authors     = ["Franklin Webber"]
  s.email       = ["franklin.webber@gmail.com"]
  s.homepage    = "https://github.com/burtlo/xcoder-testflight"
  s.summary     = %q{Provides a build task to push a build to test flight}
  s.description = %q{Provides the ability to easily push builds to the Test Flight application service}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = []
  s.executables   = []
  s.require_paths = ["lib"]
end
