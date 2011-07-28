# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = 'memory_scale'
  s.version = '0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Donald Ball']
  s.email = ['donald.ball@gmail.com']
  s.summary = 'Memory analyzer'
  s.files = `git ls-files`.split("\n") - ["memory_scale.gemspec"]
  s.test_files = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ['lib']
  s.rdoc_options = ['--charset=UTF-8']
  s.add_development_dependency('rake')
end
