# Controller for automated liveness check
class LiveCheckController < ApplicationController
  layout 'live_check'

  def show
    api = CairnCatalogueBrowser::CatalogueApi.new

    @view_state = {
      message: 'present',
      dataset_count: api.datasets({}).count
    }
  end
end
