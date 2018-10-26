require_relative '../config/environment'
require_relative 'api'
require_relative 'seeds_helper'

location = "houston"

headers = {
  "cache-control" => 'no-cache',
  "Authorization" => $api_key
}

bars_array = []
offset = 0

for num in (1..20)
  api_url = "https://api.yelp.com/v3/businesses/search?location=#{location}&term=bars&limit=50&offset=#{offset}"
  response = JSON.parse(RestClient.get(api_url, headers))
  (bars_array << response["businesses"]).flatten!
  offset += 50
end

bars_array.each do | bar |

  this_bar = Bar.find_or_create_by(
    name: bar["name"],
    category: bar["categories"][0]["title"],
    city: bar["location"]["city"],
    url: "https://www.yelp.com/biz/#{bar["alias"]}"
  )

  bar_reviews = review_scraper(this_bar.url)

  bar_reviews.each do | bar_review |
    this_user = User.find_or_create_by(name: bar_review["author"])

    this_review = Review.find_or_create_by(
      user: this_user,
      bar: this_bar,
      rating: bar_review["reviewRating"]["ratingValue"],
      content: bar_review["description"]
    )
  end
end
