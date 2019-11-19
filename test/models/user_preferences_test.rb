# frozen_string_literal: true

require 'test_helper'

  # Unit tests on UserPreferences
  class UserPreferencesTest < ActiveSupport::TestCase
    let(:params) do
      ActionController::Parameters
        .new(keyword: 'foo bar', search: 'foo')
        .permit(UserPreferences::PERMITTED_PARAMS)
    end

    it 'should initialize a user preferences object' do
      UserPreferences.new(params)
    end

    it 'should return true when the parameters are empty' do
      params = ActionController::Parameters.new
      UserPreferences
        .new(params)
        .empty?
        .must_equal true
    end

    it 'should convert the parameters to a URI string' do
      UserPreferences
        .new(params)
        .as_api_param_string
        .must_equal 'keyword=foo+bar&search=foo'
    end

    it 'should return the search term' do
      UserPreferences
        .new(params)
        .search
        .must_equal 'foo'
    end

    it 'should return the activity' do
      params = ActionController::Parameters.new(activity: 'bog-snorkelling')
      UserPreferences
        .new(params)
        .activity
        .must_equal 'bog-snorkelling'
    end

    it 'should return true if the all-years param is set' do
      params = ActionController::Parameters.new(years: 'all')
      UserPreferences
        .new(params)
        .all_years?
        .must_equal true
    end

    it 'should return a list of requested years' do
      params = ActionController::Parameters.new(year: %w[2001 2002])
      UserPreferences
        .new(params)
        .years
        .must_equal [2001, 2002]
    end

    it 'should covert to a hash on request' do
      hash = UserPreferences.new(params).to_h
      hash.must_equal('keyword' => 'foo bar', 'search' => 'foo')
    end

    it 'should add a parameter on request' do
      UserPreferences
        .new(params)
        .with_param('activity', 'bog-snorkelling')
        .to_h
        .must_equal('keyword' => 'foo bar', 'search' => 'foo', 'activity' => 'bog-snorkelling')
    end

    it 'should remove a parameter on request' do
      UserPreferences
        .new(params)
        .without_param('search')
        .to_h
        .must_equal('keyword' => 'foo bar')
    end

    it 'should cope with an ampersand in the keyword' do
      params = ActionController::Parameters.new(keyword: 'foo & bar')
      UserPreferences
        .new(params)
        .as_api_param_string
        .must_equal 'keyword=foo+%26+bar'
    end
  end
