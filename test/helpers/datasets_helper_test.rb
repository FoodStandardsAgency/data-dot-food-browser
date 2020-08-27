require 'test_helper'

class DatasetsHelperTest < ActionView::TestCase
  include DatasetsHelper

  let(:prefs) do
    params = ActionController::Parameters
             .new
             .permit(UserPreferences::PERMITTED_PARAMS)
    UserPreferences.new(params)
  end

  it 'should return a link with all the years and focus set on datasets heading' do
    link = all_years_link(prefs)
    link.must_include '#next-year'
  end
end
