class RubizzaHelper
  def self.get_answer(data, message)
    info = data[message]
    info.map { |video| "<a href='#{video}'>More Info</a>" }
    info.join(" \n ")
  end
end
