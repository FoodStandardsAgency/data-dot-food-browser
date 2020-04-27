# frozen_string_literal: true

require 'test_helper'

# Unit tests on ActivityCode
class ActivityCodeTest < ActiveSupport::TestCase
  REGULATION_URI = 'http://data.food.gov.uk/codes/organisation/activities/1'

  let :codes_fixture do
    VCR.use_cassette('load_activity_codes') do
      CatalogApi.new.activity_codes
    end
  end

  it 'returns the URI of the activity code' do
    codes_fixture.by_code('1').uri.must_equal REGULATION_URI
  end

  it 'returns the label of the activity code' do
    codes_fixture.by_code('1').label.must_equal 'Regulation'
  end

  it 'returns the ID of the activity code' do
    codes_fixture.by_uri(REGULATION_URI).id.must_equal '1'
  end

  it 'returns the children of a node' do
    codes_fixture.by_code('1').narrower.each do |child|
      child.must_be_kind_of ActivityCode
    end
  end

  it 'returns an empty list of children for a leaf node' do
    codes_fixture.by_code('1-1-1').narrower.must_be_empty
  end

  it 'returns the full label of a node' do
    codes_fixture.by_code('1-1-1').full_label.must_equal(
      'Regulation / Legislation / UK'
    )
  end
end
