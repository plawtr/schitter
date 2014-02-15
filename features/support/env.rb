# Generated by cucumber-sinatra. (2014-02-14 10:29:58 +0000)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app/schitter.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Schitter

class SchitterWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  SchitterWorld.new
end
