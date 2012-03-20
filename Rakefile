require 'bundler/setup'
require "resque/tasks"
require 'resque'

Resque.redis = 'redis://aglover:f92102d2d01e71cf33b3dd14de89d282@cod.redistogo.com:9910/'

task :default => [:test]

Rake::TestTask.new(:test) do |tsk|
  tsk.test_files = FileList['test/*_test.rb']
end