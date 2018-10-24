require_relative '../config/environment'
require 'nokogiri'
require 'open-uri'


location = "houston"

api_key = "Bearer ZCGB7cghN6Tbki6ojzII7FrWTpKUxQ3FRxvxjOG1YSBFZg7LS8TULAO6gQtFodUK1ku8xcImJBqvAlqS1uAN_zhmXxyH2TYb7qHhSrB77GASx8wH_WRJOrDMCzDOW3Yx"

headers = {
  "cache-control" => 'no-cache',
  "Authorization" => api_key
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

  Bar.find_or_create_by(
    name: bar["name"],
    category: bar["categories"][0]["title"],
    city: bar["location"]["city"],
    url: "https://www.yelp.com/biz/#{bar["alias"]}"
  )



end
