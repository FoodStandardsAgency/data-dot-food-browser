# frozen_string_literal: true

# Common implementation for Cairn API objects
class CatalogApiObject
  attr_reader :json
  attr_reader :api

  def initialize(json_or_url, api)
    @json = as_json(json_or_url, api).with_indifferent_access
    @api = api
  end

  def uri
    json['@id']
  end

  def label_for(prop)
    value = json[prop]
    if value.is_a?(Hash)
      value['label'] || ((uri = value['@id']) && strip_uri_prefix(uri))
    else
      strip_uri_prefix(value)
    end
  end

  def uri_for(prop)
    value = json[prop]
    if value.is_a?(Hash)
      value['@id']
    else
      value
    end
  end

  def key?(key)
    json.key?(key)
  end

  private

  def respond_to_missing?(key)
    json[key.to_s] || super
  end

  def method_missing(key)
    s_key = key.to_s
    return json[s_key] if json.key?(s_key)

    Rails.logger.debug "method_missing could not find JSON key: #{key}"
    super
  end

  def strip_uri_prefix(uri)
    uri.gsub(%r{\Ahttps?://}, '')
  end

  def as_json(json_or_url, api)
    if json_or_url.is_a?(String)
      api.retrieve_json(json_or_url)
    else
      json_or_url
    end
  end
  end
