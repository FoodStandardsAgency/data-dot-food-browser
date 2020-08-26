# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = 'https://36b53cb8640d4b21a2342076d394e7ea:e921da4daef0454c8b3cd5551bb19410@o74279.ingest.sentry.io/2520779'
  config.environments = %w[production]
end
