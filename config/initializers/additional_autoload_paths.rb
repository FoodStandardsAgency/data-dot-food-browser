# frozen_string_literal: true

Rails.application.config.autoload_paths += [
  Rails.root.join('/app/services'),
  Rails.root.join('/app/presenters')
]
