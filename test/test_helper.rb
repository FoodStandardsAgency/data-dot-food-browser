# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

# Disable warnings
$VERBOSE = nil

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/config/'
end

require File.expand_path('../config/environment.rb', __dir__)
require 'rails/generators'

ENV['RAILS_ENV'] ||= 'test'
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'mocha/minitest'
require 'minitest/reporters'
require 'vcr'
# require 'json_expressions/minitest'
require 'byebug'

Minitest.backtrace_filter = Minitest::ExtensibleBacktraceFilter.new
# def Minitest.filter_backtrace(bt)
#   bt
# end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :faraday
  config.default_cassette_options[:re_record_interval] = 7.days
end

# Minitest assertions

module MiniTest
  module Assertions
    def assert_well_formed_html(fragment)
      doc = Nokogiri::XML(fragment)
      assert_empty doc.errors
    end

    def assert_truthy(proposition)
      assert proposition
    end

    def assert_not_truthy(proposition)
      assert !proposition
    end
  end
end

Object.infect_an_assertion :assert_truthy, :must_be_truthy, :unary
Object.infect_an_assertion :assert_not_truthy, :must_not_be_truthy, :unary

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + '/files'
  ActiveSupport::TestCase.fixtures :all
end
