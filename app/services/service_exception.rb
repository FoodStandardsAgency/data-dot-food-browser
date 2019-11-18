# frozen_string_literal: true

# Exception class for runtime service access problems
class ServiceException < RuntimeError
  attr_reader :status, :source, :service_message

  def initialize(msg, status, source = nil, service_msg = nil)
    super(msg)

    @status = status
    @source = source
    @service_msg = service_msg
  end
end
