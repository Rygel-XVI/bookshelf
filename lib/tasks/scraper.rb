class Scraper

  def scrape_accelerated_reader(url)
    require 'open-uri'
    doc = Nokogiri::HTML(open(url))
    binding.pry
    a = doc.css("td .zero, td .guts div")

  end


end
