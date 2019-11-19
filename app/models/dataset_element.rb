# frozen_string_literal: true

# Encapsulates an individual element of a dataset
class DatasetElement < CatalogApiObject
  include Comparable

  def distributions
    d = key?(:distribution) ? distribution : []
    Array.wrap(d)
         .map { |a| DatasetDistribution.new(a, api) }
  end

  def start_date
    @start_date ||= Date.parse(startDate) if key?(:startDate)
  end

  def end_date
    @end_date ||= Date.parse(endDate) if key?(:endDate)
  end

  def years
    if start_date && end_date
      (start_date.year..end_date.year).to_a
    elsif start_date
      [start_date.year]
    elsif end_date
      [end_date.year]
    else
      []
    end
  end

  def sort_key
    if key?(:startDate)
      start_date
    elsif key?(:endDate)
      end_date
    else
      default_sort_key
    end
  end

  def secondary_sort_key
    key?(:title) ? title : '_no_sort_key'
  end

  def <=>(other)
    cmp = sort_key <=> other.sort_key
    cmp.zero? ? (secondary_sort_key <=> other.secondary_sort_key) : cmp
  end

  private

  def default_sort_key
    Date.today
  end
end
