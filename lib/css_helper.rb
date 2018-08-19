require_relative 'helper'

class CssHelper
  def self.get_answer(data, message)
    info = data[message]
    description = info["description"]
    link = info['link']
    result = "<b>#{message}</b> - #{description}\n"
    result << "<a href='#{link}'>More Info</a>"
    result
  end
end
