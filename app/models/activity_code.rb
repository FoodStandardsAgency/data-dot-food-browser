# frozen_string_literal: true

# Encapsulates an activity code
class ActivityCode < CatalogApiObject
  attr_accessor :broader

  def uri
    json['@id']
  end

  def label
    json['label']
  end

  def id
    (json['notation'] || code_details.id).to_s
  end

  def narrower
    @narrower ||= (json['narrower'] || []).map do |child_json|
      child = ActivityCode.new(child_json, api)
      child.broader = self
      child
    end
  end

  def full_label
    api.activity_codes.full_label(uri: uri)
  end

  private

  def code_details
    api.activity_codes.by_uri(uri)
  end
end
