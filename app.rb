require 'telegram/bot'
require 'colorize'
require 'pry'
require_relative 'lib/message_responder'
require_relative 'lib/database'

TOKEN = "621566334:AAHdcwORww9rxsEFsgeosc1EIi6oRkyL-fw".freeze

class Bot
  def initialize
    @token = TOKEN
    @data = Database.get_hash
  end

  def run
    puts 'TagHelper started'.green
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        options = { bot: bot, message: message, data: @data }
        MessageResponder.new(options).respond
      end
    end
  end
end

Bot.new.run
