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

    count = 0
    for i in (0..100)
        reviews = JSON.parse(doc.css('script')[i].inner_text)
        if reviews["review"] != nil
         break
        end
    end
    reviews["review"]
end
