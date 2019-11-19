# frozen_string_literal: true

OGL_LICENSE_URI = 'http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/'

# Facade object encapsulating the JSON description of a DataSet
class Dataset < CatalogApiObject
  def uri
    json['@id']
  end

  def issue_date
    Date.parse json['issued']
  end

  def modification_date
    key?('modified') && Date.parse(json['modified'])
  end

  def directorate_label
    directorate && directorate['label']
  end

  def keywords
    Array(json['keyword'] || [])
  end

  def id
    uri.match(%r{/([^/]*)\Z})[1]
  end

  def update_period
    period = json['accrualPeriodicity']
    SimpleRepeatIntervalParser.new(period).to_s if period
  end

  def elements
    @elements ||= load_elements
  end

  def license_name
    label_for('license')
  end

  def license_uri
    uri_for('license')
  end

  def years
    if start_date && end_date
      ((start_date.year)..(end_date.year)).to_a
    else
      []
    end
  end

  def description
    json['description'] || 'No description'
  end

  def start_date
    @start_date ||= Date.parse(startDate) if key?(:startDate)
  end

  def end_date
    @end_date ||= Date.parse(endDate) if key?(:endDate)
    @end_date ||= implicit_end_date
  end

  def date_range
    { from: start_date, to: end_date }
  end

  def activity
    json.key?(:activity) && json[:activity]
  end

  def activities
    @activities ||= (activity || []).map { |json| ActivityCode.new(json, api) }
  end

  private

  def load_elements
    [json['elements']]
      .flatten
      .compact
      .map { |elem| DatasetElement.new(elem, api) }
      .sort
  end

  def implicit_end_date
    Date.today if key?(:startDate)
  end
end
