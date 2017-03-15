# Simple view state container to pass to exception view
class ExceptionControllerViewState
  attr_reader :msg
  attr_reader :status

  def initialize(msg, status)
    @msg = msg
    @status = status
  end

  def show_highlighted?
    false
  end
end

# Controller that also acts a Rack middleware app to
# handle exceptions
class ExceptionController < ActionController::Base
  layout 'application'

  def render_error
    exception = env['action_dispatch.exception']
    wrapped_exception = ActionDispatch::ExceptionWrapper.new(env, exception)
    @view_state = setup_view(wrapped_exception)

    render 'error_page', status: @view_state.status
  end

  private

  def setup_view(wex)
    ex = wex.exception

    case
    when ex.is_a?(CairnCatalogBrowser::ServiceException)
      setup_service_exception_view(ex)
    when ex.is_a?(ActionController::RoutingError)
      setup_not_found_exception_view(ex)
    else
      setup_default_exception_view(ex)
    end
  end

  def setup_service_exception_view(ex)
    svc_exception = ex.exception
    Rails.logger.debug("ServiceException #{svc_exception.message} \
      #{svc_exception.status} \
      #{svc_exception.service_message} from #{svc_exception.source}")
    ExceptionControllerViewState.new(svc_exception.message, svc_exception.status)
  end

  def setup_not_found_exception_view(ex)
    Rails.logger.debug(ex.exception)
    ExceptionControllerViewState.new(
      "Not found: #{ex.exception.message}", 404
    )
  end

  def setup_default_exception_view(ex)
    Rails.logger.debug(ex.exception)
    ExceptionControllerViewState.new(
      "Sorry, something went wrong: #{ex.exception.message}", 500
    )
  end
end
