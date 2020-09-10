# frozen_string_literal: true

# Encapsulates a question we ask on the feedback form
class FeedbackQuestion
  attr_reader :id, :prompt, :input_type, :autocomplete_type

  DEFAULT_AUTOCOMPLETE_TYPE = 'off'

  def initialize(question_def)
    @id = question_def['id']
    @prompt = question_def['prompt']
    @hidden = question_def['hidden']
    @input_type = question_def['input_type']
    @autocomplete_type = question_def['autocomplete_type'] || DEFAULT_AUTOCOMPLETE_TYPE
  end

  def hidden?
    @hidden
  end
end
