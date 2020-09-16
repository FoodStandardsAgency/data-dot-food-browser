# frozen_string_literal: true

# Simple view state container to pass to exception view
class ExceptionControllerViewState
  attr_reader :msg, :status

  def initialize(msg, status, title = nil)
    @msg = msg
    @status = status
    @title = title
  end

  def show_highlighted?
    false
  end

  def page_title
    @title || @msg
  end
end

# Controller that also acts a Rack middleware app to
# handle exceptions
class ExceptionController < ApplicationController
  layout 'application'

  def render_error
    ex = env['action_dispatch.exception']
    @view_state = view_state(ex)

    render 'error_page', status: @view_state.status
  end

  def render_404
    ex = ActionController::RoutingError.new('')
    @view_state = view_state(ex)

    render 'error_page', status: :not_found
  end

  private

  def view_state(exception)
    setup_view(ActionDispatch::ExceptionWrapper.new(request.env, exception))
  end

  def setup_view(wex)
    ex = wex.exception

    if ex.is_a?(ActionController::RoutingError) || ex.status == 404
      setup_not_found_exception_view(ex)
    elsif ex.is_a?(ServiceException)
      setup_service_exception_view(ex)
    else
      setup_default_exception_view(ex)
    end
  end

  def setup_service_exception_view(exception)
    svc_exception = exception.exception
    Rails.logger.debug("ServiceException #{svc_exception.message} \
      #{svc_exception.status} \
      #{svc_exception.service_message} from #{svc_exception.source}")
    ExceptionControllerViewState.new(svc_exception.message, svc_exception.status,
                                     'Something has gone wrong')
  end

  def setup_not_found_exception_view(exception)
    Rails.logger.debug(exception.exception)
    ExceptionControllerViewState.new(
      "Not found: #{exception&.exception&.message}", 404, 'Page not found'
    )
  end

  def setup_default_exception_view(exception)
    Rails.logger.debug(exception.exception)
    ExceptionControllerViewState.new(
      "Sorry, something went wrong: #{exception.exception.message}", 500,
      'Something has gone wrong (500)'
    )
  end
end
