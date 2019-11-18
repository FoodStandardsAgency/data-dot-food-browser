# frozen_string_literal: true

# Parser for simple instances of ISO8601 interval strings
class SimpleRepeatIntervalParser
  REPEAT_UPDATE_ONE_SECOND = 'R/PT1S'

  REPEAT_INTERVAL_SINGLE = {
    Y: 'every year',
    M: 'every month',
    D: 'every day'
  }.freeze

  REPEAT_INTERVAL_MULTIPLE = {
    Y: 'years',
    M: 'months',
    D: 'days'
  }.freeze

  def initialize(interval_str)
    @interval_str = interval_str
  end

  def valid?
    @interval_str =~ %r{R/P[^T]*(T.*)?\Z}
  end

  def to_s
    if valid?
      parse_string(@interval_str)
    else
      'not a recognised interval'
    end
  end

  private

  def parse_string(str)
    if (match = str.match(%r{R/P(\d+)([YMD])\Z}))
      parse_as_simple_date_interval(match[1].to_i, match[2])
    elsif str == REPEAT_UPDATE_ONE_SECOND
      'near real-time'
    else
      "complex interval: #{str}"
    end
  end

  def parse_as_simple_date_interval(num, date_type)
    if num == 1
      REPEAT_INTERVAL_SINGLE[date_type.to_sym]
    else
      "every #{num} #{REPEAT_INTERVAL_MULTIPLE[date_type.to_sym]}"
    end
  end
end
