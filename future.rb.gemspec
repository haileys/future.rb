$:.unshift File.expand_path("../lib", __FILE__)
require "future"

Gem::Specification.new do |s|
  s.name = "future.rb"
  s.version = Future::VERSION
  s.summary = "A simple concurrent futures library for Ruby."
  s.description = "A simple concurrent futures library for Ruby with the goal of making concurrent/asynchronous programming easier."
  s.author = "Charlie Somerville"
  s.email = "charlie@charliesomerville.com"
  s.homepage = "https://github.com/charliesome/future.rb"
  s.license = "MIT"
  s.files = `git ls-files`.split("\n")
end
