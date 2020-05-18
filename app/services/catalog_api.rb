# frozen_string_literal: true

# Service wrapper for the catalog API
class CatalogApi
  DATASET_API_ROOT = '/catalog/data/dataset'

  attr_reader :api

  def initialize
    @api = JsonApi.new(
      url_base: api_host,
      payload_path: ['items']
    )
  end

  def datasets(options)
    api.map(DATASET_API_ROOT, options) { |json| Dataset.new(json, self) }
  end

  def dataset(dataset_id, options = {})
    Dataset.new(api.retrieve("#{DATASET_API_ROOT}/#{dataset_id}", options), self)
  end

  def dataset_element(element_id, options = {})
    DatasetElement.new(api.retrieve("#{DATASET_API_ROOT}/#{element_id}", options), self)
  end

  def dataset_element_by_uri(element_uri, options = {})
    match = element_uri.match(%r{/([^/]*/element/[^/]*)\Z})
    raise "Not an element URI: #{element_uri}" unless match[1]

    dataset_element(match[1], options)
  end

  def activity_codes
    unless @activity_codes
      codes = api.map('/catalog/data/activities') do |json|
        ActivityCode.new(json, self)
      end

      @activity_codes = ActivityCodes.new(codes)
    end
    @activity_codes
  end

  def retrieve_json(url)
    api.retrieve(as_relative_path(url), {})
  end

  private

  def as_relative_path(url)
    if http_endpoint?(url)
      url.match(%r{https?://[^/]*(/.*)\Z})[1]
    else
      url
    end
  end

  def http_endpoint?(url)
    url =~ /^http/
  end

  def api_host
    unless defined?(Rails) &&
      Rails.application.config.api_host &&
      !Rails.application.config.api_host.empty?
      raise 'Environment variable FSA_DATA_DOT_FOOD_API_URL is not defined'
    end

    Rails.application.config.api_host
  end
end
