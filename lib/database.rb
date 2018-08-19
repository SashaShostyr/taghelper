require 'json'

class Database
  def self.get_hash
    @hash = JSON.parse(File.read('data.json'))
  end
end
