# rakefile for the Jekyll plugins.
#
# Copyright (C) 2012 Marcus Stollsteimer

require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.pattern = 'test/**/test_*.rb'
  t.ruby_opts << '-rubygems'
  t.verbose = true
  t.warning = true
end
