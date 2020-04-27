# frozen_string_literal: true

require 'test_helper'

# Unit tests on Dataset model class
class CatalogApiObjectTest < ActiveSupport::TestCase
  EXAMPLE_OBJ = 'http://data.food.gov.uk/catalog/data/distribution/23f65130-7026-4c84-9e1b-9b3eb1e3c956'

  let :fixture do
    CatalogApiObject.new({  '@id' => 'http://example.com/foo/bar',
                            'bill' => 'the cat',
                            'opus' => {
                              'label' => 'penguin',
                              'type' => 'http://opus.com/penguin'
                            },
                            'milo' => 'http://milo.is/smart',
                            'abby' => {
                              '@id' => 'http://abby.is/awesome'
                            } }, nil)
  end

  it 'will create an api object instance' do
    fixture.wont_be_nil
  end

  it 'provides a reference to the embedded json object' do
    fixture.json.must_respond_to :keys
  end

  it 'must return the URI of the resource' do
    fixture.uri.must_equal 'http://example.com/foo/bar'
  end

  it 'must return the textual label when defined' do
    fixture.label_for('opus').must_equal('penguin')
  end

  it 'must return a plausible value when the label is not defined' do
    fixture.label_for('milo').must_equal('milo.is/smart')
    fixture.label_for('abby').must_equal('abby.is/awesome')
  end

  it 'must return the uri of an embedded value on request' do
    fixture.uri_for('abby').must_equal('http://abby.is/awesome')
    fixture.uri_for('milo').must_equal('http://milo.is/smart')
  end

  it 'must look up JSon properties on request' do
    fixture.bill.must_equal('the cat')
  end

  it 'retrieves JSON if initialised with only a URI' do
    VCR.use_cassette('dataset_distribution') do
      api = CatalogApi.new
      cobj = CatalogApiObject.new(EXAMPLE_OBJ, api)

      cobj.uri.must_equal EXAMPLE_OBJ
      cobj.identifier.must_be_kind_of String
      cobj.identifier.wont_be_empty
    end
  end
end
