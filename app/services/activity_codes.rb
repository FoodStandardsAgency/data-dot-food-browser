# frozen_string_literal: true

# Encapsulate the collection of codes for FSA activities
class ActivityCodes
  def initialize(code_list)
    @codes = {}
    index_all(@codes, code_list)
  end

  def by_uri(uri)
    @codes[uri]
  end

  def by_code(id)
    @codes.values.find do |code|
      code.id.to_s == id
    end
  end

  def full_label(params)
    uri = params[:uri] || by_code(params[:id]).uri
    code = by_uri(uri)
    raise "No such activity: #{uri}" unless code

    all_codes = with_parents(code, [])
    all_codes.map(&:label).join(' / ')
  end

  private

  def index_all(index, codes)
    codes.each do |code|
      index[code.uri] = code
      index_all(index, code.narrower)
    end
  end

  def with_parents(code, acc)
    acc_ = [code] + acc
    code.broader ? with_parents(code.broader, acc_) : acc_
  end
end
