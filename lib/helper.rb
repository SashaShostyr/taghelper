require 'fuzzy_match'
require 'translit'

class Helper
  def self.find(data, name)
    list_tags = data.keys
    FuzzyMatch.new(list_tags).find(name)
  end
end
