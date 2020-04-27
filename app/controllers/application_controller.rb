class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Create a new user preferences object from the
  def user_preferences(params)
    UserPreferences.new(validated_params(params))
  end

  # Return a validated set of request parameters
  def validated_params(prms)
    (prms || params)
      .permit(*UserPreferences::PERMITTED_PARAMS)
  end
end
