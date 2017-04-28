require 'open-uri'

class ScrapAlexa
  def initialize
    Site.destroy_all
    @page = Nokogiri::HTML(open("http://www.alexa.com/topsites"))
  end

  def run!
    @page.css('div.tr.site-listing').each do |site_node|
      site = Site.new
      site.rank = site_node.css('div.td.number').text().to_i
      site.name = site_node.css('div.td.DescriptionCell').css('p').css('a').text()
      site.url  = "http://#{site.name}"
      site.description = site_node.css('div.description').text()
      site.save
    end
  end
end