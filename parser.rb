require 'mechanize'
require 'json'
require 'pry'

agent = Mechanize.new

data = {
  HTML: {},
  CSS: {},
  RUBIZZA: {
    "Views, Controllers, and Forms": ["https://www.youtube.com/watch?v=EG2azvM1U14"],
    "Metaprogramming": ["https://www.youtube.com/watch?v=XVasDCE7lu4"],
    "Routes": ["https://www.youtube.com/watch?v=Zgvw6gcen0E"],
    "Models and Database": ["https://www.youtube.com/watch?v=NjrGImBZggg"],
    "API": ["https://www.youtube.com/watch?v=crSRmW9hmdg"],
    "Rails": ["https://www.youtube.com/watch?v=xjAr-kgN_nA"],
    "Threads and Processes": ["https://www.youtube.com/watch?v=T3tPgUlzug8"],
    "Patterns": ["https://www.youtube.com/watch?v=nT9sayKnb6Y"],
    "Tests": ["https://www.youtube.com/watch?v=eVSaLSpHHpY"],
    "Wheel of projects": ["https://www.youtube.com/watch?v=qHzUuqYxRv8"],
    "Exceptions": ["https://www.youtube.com/watch?v=RUbK8En-fAY"],
    "Variables, expressions, standart types": ["https://www.youtube.com/watch?v=DaGy0PQH8SE"],
    "Git": ["https://www.youtube.com/watch?v=Se-4Mf2m5uE"],
    "OOP": ["https://www.youtube.com/watch?v=ofEWAqAmhbY", "https://www.youtube.com/watch?v=l8d4h9AttBE", "https://www.youtube.com/watch?v=mSVY1wYOlP4"],
    "Event1": ["https://www.youtube.com/watch?v=X5lk1-_oNeQ", "https://www.youtube.com/watch?v=1HZYHpol_YU", "https://www.youtube.com/watch?v=VEdbhg_TSOY"],
    "Ruby": ["https://www.youtube.com/watch?v=Xr4UahRAtHs", "https://www.youtube.com/watch?v=mSVY1wYOlP4"],
    "Intro": ["https://www.youtube.com/watch?v=myaANa2AxNg"]
  }
}

# HTML data

page = agent.get("https://html.com/tags")

tags_html = page.search(".flat-cat").children

tags_html.each do |el|
  name, desc = el.search('td')
  href = name.at('a').attributes["href"].value
  name = name.text.split.first.slice(/\w+/)
  desc = desc.text.gsub("<","&lt;")
  desc = desc.gsub(">","&gt;")
  data[:HTML][name] = {description: desc, link: href}
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
