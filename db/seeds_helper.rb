require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

def review_scraper(url)
    html = open(
        url, 
        "User-Agent" => "Ruby/#{RUBY_VERSION}",
        "From" => "foo@bar.invalid",
        "Referer" => "http://www.ruby-lang.org/"
        )

    doc = Nokogiri::HTML(html)

    reviews = JSON.parse(doc.css('script')[7].inner_text)
    reviews["review"]
end
