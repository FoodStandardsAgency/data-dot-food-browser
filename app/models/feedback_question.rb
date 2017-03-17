# Encapsulates a question we ask on the feedback form
class FeedbackQuestion
  attr_reader :id
  attr_reader :prompt
  attr_reader :input_type

  def initialize(question_def)
    @id = question_def['id']
    @prompt = question_def['prompt']
    @hidden = question_def['hidden']
    @input_type = question_def['input_type']
  end

  def hidden?
    @hidden
  end
end