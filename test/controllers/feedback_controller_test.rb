# frozen_string_literal: true

require 'test_helper'

# Controller tests for FeedbackController
class FeedbackControllerTest < ActionDispatch::IntegrationTest
  describe 'FeedbackController' do
    it 'should show the feedback questions if there is a referring URL' do
      get feedback_url, headers: { Referer: 'https://data.food.gov.uk/catalog' }
      assert_response :success
    end

    it 'should show the feedback questions if there is no referrer' do
      get feedback_url
      assert_response :success
    end
  end
end
