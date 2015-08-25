require 'azure'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'simplecov'
require 'simplecov-console'

SimpleCov.start do
  add_filter '/spec'
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ]
end

RSpec.configure do |config|
  config.mock_with :rspec
end

RSpec::Matchers.define :require_string_for do |property|
  match do |type_class|
    config = {name: 'name'}
    config[property] = 2
    expect do
      type_class.new(config)
    end.to raise_error(Puppet::Error, /#{property} should be a String/)
  end
  failure_message do |type_class|
    "#{type_class} should require #{property} to be a String"
  end
end

RSpec::Matchers.define :require_hash_for do |property|
  match do |type_class|
    config = {name: 'name'}
    config[property] = 2
    expect do
      type_class.new(config)
    end.to raise_error(Puppet::Error, /#{property} should be a Hash/)
  end
  failure_message do |type_class|
    "#{type_class} should require #{property} to be a Hash"
  end
end

RSpec::Matchers.define :require_integer_for do |property|
  match do |type_class|
    config = {name: 'name'}
    config[property] = 'string'
    expect do
      type_class.new(config)
    end.to raise_error(Puppet::Error, /#{property} should be an Integer/)
  end
  failure_message do |type_class|
    "#{type_class} should require #{property} to be a Integer"
  end
end

RSpec::Matchers.define :be_read_only do |property|
  match do |type_class|
    config = {name: 'name'}
    config[property] = 'invalid'
    expect do
      type_class.new(config)
    end.to raise_error(Puppet::Error, /#{property} is read-only/)
  end
  failure_message do |type_class|
    "#{type_class} should require #{property} to be read-only"
  end
end
