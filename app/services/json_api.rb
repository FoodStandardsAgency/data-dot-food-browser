# frozen_string_literal: true

# Service wrapper for services that connect over http and return JSON
# Initialize with config options object. Config values:
# * url_base - prepdended to the start of relative URLs
# * payload_path - use to access the payload from the response object,
# *                e.g. ["options"]
class JsonApi # rubocop:disable Metrics/ClassLength
  attr_reader :config

  def initialize(config = {})
    @config = config
  end

  def url_base(options = {})
    option_value(options, :url_base)
  end

  def payload_path(options = {})
    option_value(options, :payload_path)
  end

  def retrieve(endpoint, options)
    payload(api_get_json(endpoint, options), options).first
  end

  def retrieve_all(endpoint, options)
    payload_as_array(api_get_json(endpoint, options), options)
  end

  def each(endpoint, options = {}, &block)
    result = api_get_json(endpoint, options)
    payload_as_array(result, options).each(&block)
  end

  def map(endpoint, options = {}, &block)
    result = api_get_json(endpoint, options)
    payload_as_array(result, options).map(&block)
  end

  private

  def api_get_json(endpoint, options = {})
    get_json(as_http_endpoint(endpoint, options), options)
  end

  def payload(result, options)
    path = payload_path(options)
    path.inject(result) { |a, e| a[e] }
  end

  def option_value(options, key)
    options[key] || config[key]
  end

  def payload_as_array(result, options)
    if (p = payload(result, options)).is_a?(Array)
      p
    else
      [p]
    end
  end

  # Get parsed JSON from the given URL
  def get_json(http_url, options)
    response = get_from_api(http_url, options)
    parse_json(response.body)
  end

  def get_from_api(http_url, options)
    conn = connection_timeout(create_http_connection(http_url))
    http_options = options[:http_options] || {}

    response = conn.get do |req|
      req.headers['Accept'] = 'application/json'
      req.params.merge! http_options
    end

    ok?(response, http_url) && response
  end

  # Parse the given JSON string into a data structure. Throws an exception if
  # parsing fails
  def parse_json(json)
    result = nil

    json_hash = parser.parse(StringIO.new(json)) do |json_chunk|
      result = accumulate_json(result, json_chunk)
    end

    report_json_failure(json) unless result || json_hash
    result || json_hash
  end

  def accumulate_json(acc, json_chunk)
    if acc
      result = [acc] unless acc.is_a?(Array)
      result << json_chunk
    else
      result = json_chunk
    end

    result
  end

  def create_http_connection(http_url)
    Faraday.new(url: http_url) do |faraday|
      faraday.request  :url_encoded
      faraday.use      FaradayMiddleware::FollowRedirects
      log_if_rails(faraday)
      faraday.adapter  :net_http
    end
  end

  def connection_timeout(conn)
    conn.options[:timeout] = 600
    conn
  end

  def ok?(response, http_url)
    unless (200..207).cover?(response.status)
      msg = "Failed to read from #{http_url}: #{response.status.inspect}"
      raise CairnCatalogBrowser::ServiceException.new(msg, response.status,
                                                      http_url, response.body)
    end

    true
  end

  def log_if_rails(faraday)
    faraday.response(:logger, Rails.logger) if defined?(Rails) && Rails.env.development?
  end

  def as_http_endpoint(endpoint, options)
    base = endpoint.start_with?('http:') ? endpoint : "#{url_base(options)}#{endpoint}"
    base + url_params(options)
  end

  def url_params(options)
    options[:url_params] ? url_params_string(options[:url_params]) : ''
  end

  def url_params_string(url_params)
    # TODO: convert hash to string
    "?#{url_params}"
  end

  protected

  def parser
    @parser ||= Yajl::Parser.new
  end

  def report_json_failure(json)
    if defined?(Rails)
      msg = 'JSON result was not parsed correctly (no temp file saved)'
      Rails.logger.info(msg)
      throw msg
    else
      throw "JSON result was not parsed correctly: #{json.slice(0, 1000)}"
    end
  end
end
