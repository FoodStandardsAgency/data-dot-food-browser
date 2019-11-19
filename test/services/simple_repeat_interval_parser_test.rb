# frozen_string_literal: true

require 'test_helper'

# Unit tests on SimpleRepeatIntervalParser
class SimpleRepeatIntervalParserTest < ActiveSupport::TestCase
  it 'can create a parser instance' do
    SimpleRepeatIntervalParser.new('R/P1D').wont_be_nil
  end

  it 'reports if a string is a valid interval' do
    parser = SimpleRepeatIntervalParser.new('R/P1D')
    parser.valid?.must_be_truthy
  end

  it 'reports if a string is not a valid interval' do
    parser = SimpleRepeatIntervalParser.new('P1D')
    parser.valid?.must_not_be_truthy
  end

  it 'does not parse an invalid string' do
    parser = SimpleRepeatIntervalParser.new('P1D')
    parser.to_s.must_equal 'not a recognised interval'
  end

  it 'parses a repeat once per day interval' do
    SimpleRepeatIntervalParser.new('R/P1D').to_s.must_equal('every day')
  end

  it 'parses a repeat once per month interval' do
    SimpleRepeatIntervalParser.new('R/P1M').to_s.must_equal('every month')
  end

  it 'parses a repeat once per year interval' do
    SimpleRepeatIntervalParser.new('R/P1Y').to_s.must_equal('every year')
  end

  it 'parses a repeat every 3 days interval' do
    SimpleRepeatIntervalParser.new('R/P3D').to_s.must_equal('every 3 days')
  end

  it 'parses a repeat every 3 months interval' do
    SimpleRepeatIntervalParser.new('R/P3M').to_s.must_equal('every 3 months')
  end

  it 'parses a repeat every 3 years interval' do
    SimpleRepeatIntervalParser.new('R/P3Y').to_s.must_equal('every 3 years')
  end
end
