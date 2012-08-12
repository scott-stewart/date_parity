#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'test/lib'
  t.pattern = 'test/*_test.rb'
end

