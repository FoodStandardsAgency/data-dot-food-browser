# frozen_string_literal: true

# Use AWS to send email
Rails.application.config.action_mailer.delivery_method = :ses
