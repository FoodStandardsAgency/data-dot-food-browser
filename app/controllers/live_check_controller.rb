# Controller for automated liveness check
class LiveCheckController < ApplicationController
  layout 'live_check'
  before_action :set_cache_headers

  def show
    api = CatalogApi.new

    @view_state = {
      message: 'present',
      dataset_count: api.datasets({}).count
    }
  end

  private

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Mon, 01 Jan 1990 00:00:00 GMT'
  end
end
