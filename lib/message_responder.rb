require_relative 'message_sender'
require_relative 'html_helper'
require_relative 'css_helper'

class MessageResponder
  attr_reader :message
  attr_reader :bot

  HELP = <<EOS
/start - Run TagHelperBot\n
/stop - Stop TagHelperBot\n
/help - Get bot commands\n
/change_category - Choose language which you interested in
EOS

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @data = options[:data]
  end

  def respond
    case @message.text
    when '/start'
      answers = %w[HTML CSS]
      answer_with_answers("Привет, #{get_user} 😄", answers)
    when '/stop'
      answer_with_farewell_message
    when '/help'
      answer_with_message HELP
    when 'HTML'
      answer_with_message "Введи HTML tag"
      @bot.listen do |message|
        case message.text
        when '/help'
          answer_with_message HELP
        when '/change_category'
          answers = %w[HTML CSS]
          answer_with_answers("Выбери категорию", answers)
          return
        else
          get_answer(@data["HTML"], message.text, "HTML")
        end
      end
    when 'CSS'
      answer_with_message "Введи CSS property"
      @bot.listen do |message|
        case message.text
        when '/help'
          answer_with_message HELP
        when '/change_category'
          answers = %w[HTML CSS]
          answer_with_answers("Выбери категорию", answers)
          return
        else
          get_answer(@data["CSS"], message.text, "CSS")
        end
      end
    end
  end

  def get_answer(data_category, name, category)
    list_tags = data_category.keys
    if list_tags.include? name
      answer_with_message get_info(data_category, name, category)
    else
      suggested_name = Helper.find(data_category, name)
      answers = %w[Да Нет]
      answer_with_answers("Вы имеете ввиду \'#{suggested_name}\'?", answers)
      confirmation = confirm(data_category, suggested_name, category)
      answer_with_message confirmation
    end
  end

  def confirm(data_category, name, category)
    @bot.listen do |answer|
      case answer.text
      when 'Да'
        info = get_info(data_category, name, category)
        return info
      when 'Нет'
        return 'Нет данных!!!'
      end
    end
  end

  def get_info(data_category, name, category)
    case category
    when "HTML"
      HtmlHelper.get_answer(data_category, name)
    when "CSS"
      CssHelper.get_answer(data_category, name)
    end
  end

  def answer_with_farewell_message
    answer_with_message "Пока, #{get_user} 😂 "
  end

  def get_user
    "#{@message.from.first_name} #{@message.from.last_name}"
  end

  def answer_with_message(text)
    MessageSender.new(bot: bot, chat: message.chat, text: text).send
  end

  def answer_with_answers(t, ans)
    MessageSender.new(bot: bot, chat: message.chat, text: t, answers: ans).send
  end
end
