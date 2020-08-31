# frozen-string-literal: true

require 'assets_proxy'
Rails.application.config.middleware.unshift(AssetsProxy)
