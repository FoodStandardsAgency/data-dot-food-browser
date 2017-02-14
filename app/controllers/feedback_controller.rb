# Simple controller for feedback form
class FeedbackController < ApplicationController
  def show
  end

  def create
    Rails.logger.debug 'TODO forward feedback'
    redirect_to controller: 'cairn_catalogue_browser/datasets', action: :index
  end
end
