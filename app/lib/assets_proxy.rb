# frozen-string-literal: true

# Rack proxy to map assets requests in development
class AssetsProxy < Rack::Proxy
  DEPLOYMENT_PATH_PATTERN = %r{^/catalog}.freeze

  def perform_request(env)
    request = Rack::Request.new(env)

    if !Rails.env.production? && request.path.match?(DEPLOYMENT_PATH_PATTERN)
      env['PATH_INFO'] = request.path.sub(DEPLOYMENT_PATH_PATTERN, '')
    end

    @app.call(env)
  end
end
