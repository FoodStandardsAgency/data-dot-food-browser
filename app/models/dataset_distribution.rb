# frozen_string_literal: true

# Model object encapsulating dataset distributions
class DatasetDistribution < CatalogApiObject
  def media_type
    json['mediaType']
  end

  def preferred_url
    download_url || access_url
  end

  def access_url
    json['accessURL']
  end

  def download_url
    json['downloadURL']
  end
end
