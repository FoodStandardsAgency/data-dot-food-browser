# frozen_string_literal: true

# Base mailer class
class ApplicationMailer < ActionMailer::Base
  default from: "data-dot-food-browser@epimorphics.com"
  layout 'mailer'
end
