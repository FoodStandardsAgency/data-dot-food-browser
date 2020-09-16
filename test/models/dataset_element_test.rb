# frozen_string_literal: true

require 'test_helper'
require 'faraday_middleware'
require 'yajl'

# Unit tests on Dataset model class
class DatasetElementTest < ActiveSupport::TestCase
  let :element_fixture do
    VCR.use_cassette('load_dataset_element') do
      api = CatalogApi.new
      api.dataset_element('c27423b7-775c-4220-a626-638fecd409a7/element/57bee23ec56bb56904388aad33176a5d')
    end
  end

  it 'should return the start date if defined' do
    element_fixture.start_date.must_be_kind_of Date
    element_fixture.start_date.must_equal(Date.parse('2016-01-01'))
  end

  it 'should return nil if the start date is not defined' do
    DatasetElement.new({ endDate: '2017-01-01' }, nil).start_date.must_be_nil
  end

  it 'should return the end date if defined' do
    element_fixture.end_date.must_be_kind_of Date
    element_fixture.end_date.must_equal(Date.parse('2016-12-31'))
  end

  it 'should return nil if the end date is not defined' do
    DatasetElement.new({ startDate: '2017-01-01' }, nil).end_date.must_be_nil
  end

  it 'should return the distributions on request' do
    element_fixture.distributions.must_be_kind_of Array
    element_fixture.distributions.each do |dist|
      dist.must_be_kind_of DatasetDistribution
    end
  end

  it 'should return the years on request' do
    d = DatasetElement.new(
      { startDate: '2016-01-01', endDate: '2016-03-01' },
      nil
    )
    d.years.sort.must_equal [2016]

    d = DatasetElement.new(
      { startDate: '2015-01-01', endDate: '2016-03-01' },
      nil
    )
    d.years.sort.must_equal [2015, 2016]

    d = DatasetElement.new({ endDate: '2016-03-01' }, nil)
    d.years.sort.must_equal [2016]

    d = DatasetElement.new({ startDate: '2015-01-01' }, nil)
    d.years.sort.must_equal [2015]

    d = DatasetElement.new({}, nil)
    d.years.sort.must_equal []
  end

  it 'should always return a sort key' do
    k = DatasetElement.new(
      { startDate: '2016-01-01', endDate: '2016-03-01' },
      nil
    ).sort_key
    k.must_be_kind_of Date
    k.must_equal Date.parse('2016-01-01')

    k = DatasetElement.new({ endDate: '2016-03-01' }, nil).sort_key
    k.must_be_kind_of Date
    k.must_equal Date.parse('2016-03-01')

    k = DatasetElement.new({}, nil).sort_key
    k.must_be_kind_of Date
    k.year.must_equal Time.zone.now.year
  end
end
