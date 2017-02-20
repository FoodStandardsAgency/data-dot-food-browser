# Simple controller for feedback form
class FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
  end

  def create
    Rails.logger.debug 'TODO forward feedback'
    redirect_to controller: 'cairn_catalog_browser/datasets', action: :index
  end
end
