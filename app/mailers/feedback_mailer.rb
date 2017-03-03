# Send content of feedback form as email
class FeedbackMailer < ActionMailer::Base
  default from: 'fsa-data-feedback@epimorphics.com'

  def feedback_email(questions_and_answers)
    @view_state = questions_and_answers
    mail(to: 'fsa-data-feedback@epimorphics.com', subject: 'FSA data catalog feedback')
  end
end
