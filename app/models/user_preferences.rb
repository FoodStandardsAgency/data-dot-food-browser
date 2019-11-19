# frozen_string_literal: true

# Model object encapsulating the user preferences expressed by the
# incoming request parameters
class UserPreferences
  PERMITTED_PARAMS = [
    :search, :activity, :keyword, :years, :activity, :id, { year: [] }
  ].freeze

  attr_reader :keywords

  def initialize(params)
    @keywords = extract_keywords(params)
    @params = params
  end

  def empty?
    @params.empty?
  end

  def as_api_param_string
    as_api_param_pairs
      .map { |k, v| "#{k}=#{CGI.escape(v)}" }
      .join('&')
  end

  def search
    @params[:search]
  end

  def activity
    @params[:activity]
  end

  def all_years?
    @params[:years] == 'all'
  end

  def years
    @params[:year] ? @params[:year].map(&:to_i) : nil
  end

  def to_h
    @params
      .permit(*PERMITTED_PARAMS)
      .to_unsafe_hash
  end

  def with_param(key, value)
    to_h.merge(key => value)
  end

  def without_param(key)
    to_h.delete_if { |k, _v| k == key.to_s }
  end

  private

  def extract_keywords(preferences)
    preferences[:keyword] ? [preferences[:keyword]] : []
  end

  def as_api_param_pairs
    keyword_pairs + search_pair + activity_pair
  end

  def keyword_pairs
    keywords.map { |k| [:keyword, k] }
  end

  def search_pair
    search && !search.nil? ? [[:search, search]] : []
  end

  def activity_pair
    activity && !activity.nil? ? [[:activity, activity]] : []
  end
end
