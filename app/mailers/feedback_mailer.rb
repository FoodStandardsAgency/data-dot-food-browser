# frozen_string_literal: true

# Send content of feedback form as email
class FeedbackMailer < ApplicationMailer
  default from: 'data@food.gov.uk'

  def feedback_email(questions_and_answers)
    @view_state = questions_and_answers

    now = Time.zone.now.strftime('%H:%M %d-%m-%Y')
    mail(to: 'data@food.gov.uk',
         subject: "FSA data catalog feedback - #{now}")
  end
end
