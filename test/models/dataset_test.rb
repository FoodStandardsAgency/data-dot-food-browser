# frozen_string_literal: true

require 'test_helper'
require 'faraday_middleware'
require 'yajl'

  # Unit tests on Dataset model class
  class DatasetTest < ActiveSupport::TestCase
    let :dataset_fixture do
      VCR.use_cassette('load_dataset') do
        api = CatalogApi.new
        api.dataset('0cf781b6-6886-4cd1-ad68-829252b15f90')
      end
    end

    it 'will create a dataset instance' do
      dataset_fixture.wont_be_nil
    end

    it 'will return the resource URI on request' do
      dataset_fixture.uri.must_equal 'http://data.food.gov.uk/catalog/data/dataset/0cf781b6-6886-4cd1-ad68-829252b15f90'
    end

    it 'will return the description of the dataset' do
      dataset_fixture.description.must_be_kind_of String
      dataset_fixture.description.must_match(/hospitality/)
    end

    it 'will return a default description if missing' do
      Dataset.new({}, nil).description.must_be_kind_of String
      Dataset.new({}, nil).description.wont_be_empty
    end

    it 'will return the issue date' do
      dataset_fixture.issue_date.must_be_kind_of Date
    end

    it 'will return the modification date' do
      dataset_fixture.modification_date.must_be_kind_of Date
      dataset_fixture.modification_date.wont_equal dataset_fixture.issue_date
    end

    it 'will return the keywords as strings' do
      dataset_fixture.keywords.must_be_kind_of Array
      dataset_fixture
        .keywords
        .map { |kw| kw.class.name }
        .uniq
        .must_equal ['String']
    end

    it 'will return an empty list of keywords if undefined' do
      kw = Dataset.new({}, nil).keywords
      kw.must_equal []
    end

    it 'will return the dataset id' do
      dataset_fixture.id.must_be_kind_of String
      dataset_fixture.id.wont_match %r{/}
    end

    it 'will translate the accrual period to English' do
      dataset_fixture.update_period.must_match(/every/)
    end

    it 'will return the license URI' do
      dataset_fixture.license_uri.must_match(%r{http://})
    end

    it 'will return the license label' do
      dataset_fixture.license_name.downcase.must_match(/licen[sc]e/)
    end

    it 'will return the elements of the dataset without loading extra details' do
      elements = dataset_fixture.elements
      elements.must_be_kind_of Array
      elements.wont_be_empty

      elements.first.uri.must_match(/http:/)
    end

    it 'will return an empty array if there are no elements' do
      Dataset.new({}, nil).elements.must_equal []
    end

    it 'will return the directorate label' do
      dataset_fixture.directorate_label.wont_be_nil
      dataset_fixture.directorate_label.wont_be_empty
    end

    it 'will return the time range of the dataset elements' do
      dataset_fixture.date_range[:from].must_be_kind_of Date
      dataset_fixture.date_range[:to].must_be_kind_of Date
      dataset_fixture.date_range[:from].must_be :<=, dataset_fixture.date_range[:to]
    end

    it 'will report the years covered by the attached elements' do
      dataset_fixture.years.must_be_kind_of Array
      dataset_fixture.years.length.must_be :>=, 4
    end

    it 'will return an array of all of the activities under which the ds is defined' do
      VCR.use_cassette('load_activity_codes') do
        dataset_fixture.activities.length.must_equal 1
        dataset_fixture.activities.first.must_be_kind_of ActivityCode
        dataset_fixture.activities.first.label.must_equal 'HR'
      end
    end
  end
