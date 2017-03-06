# Send content of feedback form as email
class FeedbackMailer < ActionMailer::Base
  default from: 'fsa-data-feedback@epimorphics.com'

  def feedback_email(questions_and_answers)
    @view_state = questions_and_answers

    now = Time.now.strftime('%H:%M %d-%m-%Y')
    mail(to: 'fsa-data-feedback@epimorphics.com',
         subject: "FSA data catalog feedback - #{now}".html_safe)
  end
end
