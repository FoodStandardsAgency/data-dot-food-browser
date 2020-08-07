# frozen_string_literal: true

# Presenter to show feedback questions and answers
class FeedbackQuestions
  attr_reader :dataset

  def initialize(questions, dataset = nil, params = nil)
    @questions = questions
    @dataset = dataset

    question_keys = questions.map(&:id)
    question_keys << 'referer'

    @answers = params.permit(question_keys) if params
  end

  def each_q(&block)
    @questions.each(&block)
  end

  def each_qa
    @questions.each do |q|
      answer = (@answers && @answers[q.id]) || '(no answer given)'
      yield(q.id, q.prompt, answer)
    end
  end

  def show_highlighted?
    false
  end
end
