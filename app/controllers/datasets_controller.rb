# frozen_string_literal: true

# Controller for action to list all datasets, or show an particular dataset
class DatasetsController < ApplicationController
  layout 'application'

  PAGE_SIZE = 20

  def index
    @view_state = view_support(params)

    api = CatalogApi.new
    @view_state.datasets = select_datasets(@view_state, api)
    @view_state.activity_codes = api.activity_codes
    @view_state.show_highlighted_datasets = true
    render layout: 'landing'
  end

  def show
    api = CatalogApi.new
    @view_state = view_support(params)
    @view_state.dataset = api.dataset(params[:id])
  end

  private

  def select_datasets(view_state, api)
    url_params = with_compact_view(view_state.prefs.as_api_param_string)
    datasets = api.datasets(url_params: url_params)
    datasets.sort_by!(&:title)
    as_paged(filter_datasets(datasets, view_state))
  end

  def with_compact_view(params)
    "_view=compact#{params.present? ? '&' : ''}#{params}"
  end

  def view_support(params)
    DatasetsControllerViewSupport.new(
      user_preferences(params)
    )
  end

  def filter_datasets(datasets, view_state)
    filter_datasets_by_year(datasets, view_state.prefs)
  end

  def filter_datasets_by_year(datasets, prefs)
    if prefs.years.present?
      datasets.select do |dataset|
        dataset.years.any? { |year| prefs.years.include?(year) }
      end
    else
      datasets
    end
  end

  def as_paged(datasets)
    page = params[:page]
    page_size = page.to_s == 'all' ? datasets.size : PAGE_SIZE

    Kaminari.paginate_array(datasets)
            .page(page)
            .per(page_size)
  end
end

# Controller view-support class
class DatasetsControllerViewSupport
  # Number of years to show in filter by default
  SUMMARY_YEARS = 5

  attr_reader :prefs
  attr_accessor :datasets, :dataset, :activity_codes, :show_highlighted_datasets

  def initialize(user_preferences)
    @prefs = user_preferences
  end

  def keywords
    prefs.keywords.join(' ')
  end

  def search
    prefs.search
  end

  def start_date
    prefs.start_date
  end

  def end_date
    prefs.end_date
  end

  def year_options # rubocop:disable Metrics/MethodLength
    options = years.map do |year|
      {
        type: 'checkbox',
        class: 'checkbox',
        name: 'year[]',
        id: "year-#{year}",
        value: year,
        checked: check_year?(year)
      }
    end

    if set_focus?
      focus_year = [years.size - 1, SUMMARY_YEARS].min
      options[focus_year][:class] = 'checkbox u-focus-on-load'
    end

    options
  end

  def years
    prefs.all_years? ? all_years : all_years.slice(0, SUMMARY_YEARS)
  end

  def all_years
    @all_years ||= datasets
                   .map(&:years)
                   .flatten
                   .uniq
                   .sort
                   .reverse
  end

  def check_year?(year)
    prefs.years&.include?(year) || nil
  end

  def filter_defined?
    !@prefs.empty?
  end

  def show_highlighted?
    @show_highlighted_datasets
  end

  def page_title # rubocop:disable Metrics/AbcSize
    titles = []
    titles.push("search for '#{search}'") if search.present?

    if !prefs.all_years? && prefs.years
      connective = prefs.years.length > 1 ? 'one of ' : ''
      titles.push("year is #{connective}#{prefs.years.join(' ')}")
    end
    !titles.empty? && "Datasets matching: #{titles.join(' and ')}"
  end

  # If the most recent user action was the "more years" expansion, we auto-set
  # the focus to assist people who are using keyboard navigation
  def set_focus?
    prefs.user_action == 'more'
  end

  def show_more_years?
    all_years.size > years.size
  end
end
