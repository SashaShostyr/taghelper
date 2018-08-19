require 'mechanize'
require 'json'
require 'pry'

agent = Mechanize.new

data = {
  HTML: {},
  CSS: {},
  RUBY: {}
}

# HTML data

page = agent.get("https://html.com/tags")

tags_html = page.search(".flat-cat").children

tags_html.each do |el|
  name, desc = el.search('td')
  name = name.text.split.first.slice(/\w+/)
  desc = desc.text.gsub("<","&lt;")
  desc = desc.gsub(">","&gt;")
  data[:HTML][name] = desc
end

# CSS data
LINK = "https://www.w3schools.com/cssref/"

page = agent.get(LINK)

tables = page.search("table.w3-table-all")

count = 1
tables.each do |table|
  rows = table.search('tr')
  rows.each do |row|
    name, desc = row.search('td')
    if name.at('a')
      href = name.at('a').attributes['href'].value
    else
      href = "https://www.google.ru/"
    end
    href = "#{LINK}#{href}"
    data[:CSS][name.text] = {description: desc.text, link: href}
  end
  count += 1
  puts count
end

File.open('data.json', 'w') { |file| file.puts data.to_json  }
binding.pry
