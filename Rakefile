require "rake/testtask"

task default: [:test]

Rake::TestTask.new do |t|
  t.pattern = "test/**/test_*.rb"
  t.libs   << "_plugins"
  t.verbose = true
  t.warning = true
end
