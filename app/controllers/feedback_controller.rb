# Simple controller for feedback form
class FeedbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @view_state = FeedbackQuestions.new(load_questions, current_dataset)
  end

  def create
    presenter = FeedbackQuestions.new(load_questions, nil, params)
    FeedbackMailer.feedback_email(presenter).deliver_now

    redirect_to controller: 'cairn_catalog_browser/datasets', action: :index
  end

  private

  def load_questions
    YAML
      .load_file('config/feedback_questions.yml')
      .map { |question_spec| FeedbackQuestion.new(question_spec) }
  end

  def current_dataset_id
    matches = request.referer.match(%r{\A.*/datasets/([^/]+)\Z})
    matches && matches[1]
  end

  def current_dataset
    if (id = current_dataset_id)
      CatalogApi.new.dataset(id)
    end
  end
end
