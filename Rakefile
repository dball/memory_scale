# encoding: UTF-8
require 'rake'
require 'rake/testtask'
require 'rubygems/package_task'

def gemspec
  @clean_gemspec ||= eval(File.read(File.expand_path('../memory_scale.gemspec', __FILE__)))
end

Rake::TestTask.new(:test) do |test|
  test.libs = %w(lib test)
  test.pattern = "test/**/*_test.rb"
end

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.need_tar = false
  pkg.need_zip = false
end
