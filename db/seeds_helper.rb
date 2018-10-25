require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

def review_scraper(url)
    url = url.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
    html = open(
        url,
        "User-Agent" => "Ruby/#{RUBY_VERSION}",
        "From" => "foo@bar.invalid",
        "Referer" => "http://www.ruby-lang.org/"
        )

    doc = Nokogiri::HTML(html)

    for i in (6..100)
        reviews = JSON.parse(doc.css('script')[i].inner_text)
        if reviews["review"] != nil
         break
        end
    end
    reviews["review"]
end
