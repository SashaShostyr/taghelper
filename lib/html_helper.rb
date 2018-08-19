class HtmlHelper
  def self.get_answer(data, message)
    description = data[message]
    return "<b>&lt;#{message}&gt;</b> - #{description}"
  end
end
