# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    config.dsn = 'https://36b53cb8640d4b21a2342076d394e7ea:e921da4daef0454c8b3cd5551bb19410@o74279.ingest.sentry.io/2520779'

    config.before_send = lambda do |event, hint|
      ex = hint[:exception]
      if ex.is_a?(ServiceException) && ex.status == 404
        nil
      else
        event
      end
    end
  end
end
