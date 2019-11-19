# frozen_string_literal: true

require 'test_helper'

# Unit tests on ActivityCodes service object
class ActivityCodesTest < ActiveSupport::TestCase
  CODE_URI = 'http://data.food.gov.uk/codes/organisation/activities/2'

  let :codes_fixture do
    VCR.use_cassette('load_activity_codes') do
      CatalogApi.new.activity_codes
    end
  end

  it 'can look up an acivity code by URI' do
    code = codes_fixture.by_uri('http://data.food.gov.uk/codes/organisation/activities/3')
    code.wont_be_nil
    code.uri.must_equal('http://data.food.gov.uk/codes/organisation/activities/3')
  end

  it 'can determine the full label for a root node' do
    l = codes_fixture.full_label(uri: 'http://data.food.gov.uk/codes/organisation/activities/3')
    l.must_equal('Policy')
  end

  it 'can determine the full label for a second-level node' do
    l = codes_fixture.full_label(uri: 'http://data.food.gov.uk/codes/organisation/activities/1-1')
    l.must_equal('Regulation / Legislation')
  end

  it 'can determine the full label for a third-level node' do
    l = codes_fixture.full_label(uri: 'http://data.food.gov.uk/codes/organisation/activities/1-1-1')
    l.must_equal('Regulation / Legislation / UK')
  end

  it 'can determine the full label for a third-level node based on ID' do
    l = codes_fixture.full_label(id: '1-1-1')
    l.must_equal('Regulation / Legislation / UK')
  end

  it 'can look up an activity by URI' do
    codes_fixture.by_uri(CODE_URI).label.must_equal 'Research'
  end

  it 'can look up an activity by ID' do
    codes_fixture.by_code('2').label.must_equal 'Research'
  end
end
