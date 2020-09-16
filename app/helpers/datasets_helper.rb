# frozen_string_literal: true

# Helpers for datasets views
module DatasetsHelper
  def distribution_link(dist, elem)
    link_to(
      media_type_short(dist.media_type),
      dist.preferred_url,
      class: 'o-dataset-distribution--link',
      title: elem.title.to_s,
      data: {
        'mime-type' => dist.media_type
      }
    )
  end

  def media_type_short(media_type)
    {
      'text/csv' => 'csv',
      'application/json' => 'JSON',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => 'spreadsheet',
      'application/pdf' => 'pdf'
    }[media_type] || media_type
  end

  def summarise_date_range(dataset) # rubocop:disable Metrics/MethodLength
    from = dataset.date_range[:from]
    to = dataset.date_range[:to]

    capture do
      if from && to
        concat summarise_date_range_full(from, to)
      elsif from || to
        concat summarise_date_range_abbrev(from || to)
      else
        concat tag.span('Undated', class: 'c-dataset-entry--date-range__default')
      end
    end
  end

  def summarise_date_range_full(from, to)
    capture do
      concat summarise_date_range_abbrev(from)
      concat '&ndash;'.html_safe
      concat summarise_date_range_abbrev(to)
    end
  end

  def summarise_date_range_abbrev(date)
    tag.time(date.strftime('%b %Y'), datetime: date.strftime('%Y-%m-%d'))
  end

  def all_years_link(prefs)
    dest = search_index_with_params(prefs, { years: 'all', user_action: 'more' }, true)
    dest[:anchor] = 'filter-datasets__heading'
    link_to('more years&hellip;'.html_safe, dest, class: 'c-all-years-link')
  end

  def dataset_keyword_filter(keyword, prefs)
    dataset_keyword_filter_add(keyword, prefs, !keyword_selected?(keyword, prefs))
  end

  def dataset_activity_filter(activity, prefs)
    dataset_activity_filter_add(activity, prefs, !activity_selected?(activity.id, prefs))
  end

  private

  def dataset_keyword_filter_add(keyword, prefs, add)
    dataset_filter_add(:keyword, keyword, prefs, add,
                       maybe_selected_keyword(keyword, add),
                       'o-dataset-keyword__filter')
  end

  def dataset_activity_filter_add(activity, prefs, add)
    dataset_filter_add(:activity, activity.id, prefs, add,
                       maybe_selected_keyword(activity.full_label, add),
                       'o-dataset-keyword__filter')
  end

  # rubocop:disable Metrics/ParameterLists
  def dataset_filter_add(param_name, param, prefs, add, text, cls)
    dest = search_index_with_param(prefs, param_name, param, add)
    inner_text = text.gsub(/<[^>]*>/, '')

    if add
      link_to(text, dest, class: cls, 'aria-label' => "Filter for datasets matching #{inner_text}")
    else
      tag.span(text, class: cls)
    end
  end
  # rubocop:enable Metrics/ParameterLists

  def keyword_selected?(keyword, prefs)
    prefs.keywords.include?(keyword)
  end

  def activity_selected?(activity, prefs)
    prefs.activity == activity
  end

  def search_index_with_param(prefs, param, param_value, add)
    search_index_with_params(prefs, [[param, param_value]].to_h, add)
  end

  def search_index_with_params(prefs, params, add)
    params_ =
      if add
        prefs.to_h.merge(params)
      else
        prefs.to_h.except(*params.keys)
      end

    { controller: 'datasets', action: 'index', anchor: 'results' }.merge(params_)
  end

  def maybe_selected_keyword(keyword, unselected)
    cls =
      unselected ? 'o-dataset-keyword__filter--selectable' : 'o-dataset-keyword__filter--selected'
    tag.span(keyword, class: cls)
  end

  def remove_filter_button(prefs, filter_type, filter_value)
    dest = search_index_with_param(prefs, filter_type, filter_value, false)
    link_to(dest, class: 'c-filter-remove-button', title: "Remove #{filter_type} #{filter_value}") do
      tag.span('Remove filter', class: 'u-sr-only visually-hidden')
    end
  end
end
