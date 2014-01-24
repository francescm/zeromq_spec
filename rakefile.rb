#encoding: utf-8

$:.unshift "."

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "run spec"
task :rspec => :spec
