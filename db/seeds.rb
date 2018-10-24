require_relative '../config/environment'

bar1 = Bar.find_or_create_by(name: "bar 1", category: "drag bar", city: "h-town")
bar2 = Bar.find_or_create_by(name: "bar 2", category: "sports bar", city: "h-town")
bar3 = Bar.find_or_create_by(name: "bar 3", category: "dive bar", city: "h-town")
bar4 = Bar.find_or_create_by(name: "bar 4", category: "cocktail bar", city: "h-town")

user1 = User.find_or_create_by(name: "user 1")
user2 = User.find_or_create_by(name: "user 2")
user3 = User.find_or_create_by(name: "user 3")
user4 = User.find_or_create_by(name: "user 4")

rev1 = Review.find_or_create_by(user: user1, bar: bar1, rating: 3, content: "blahhhhhh")
rev2 = Review.find_or_create_by(user: user2, bar: bar1, rating: 4, content: "mehhhhhhhhh")
rev3 = Review.find_or_create_by(user: user1, bar: bar3, rating: 3, content: "ahhhhhhh")
rev4 = Review.find_or_create_by(user: user4, bar: bar2, rating: 0, content: "roaches... are you f***ing kidding me?!")
rev5 = Review.find_or_create_by(user: user3, bar: bar4, rating: 1, content: "rats... are you f***ing kidding me?!")
rev6 = Review.find_or_create_by(user: user1, bar: bar2, rating: 0, content: "my chair had poo in it!")
rev7 = Review.find_or_create_by(user: user3, bar: bar4, rating: 0, content: "I got hepatitis!")
rev8 = Review.find_or_create_by(user: user3, bar: bar4, rating: 0, content: "the food killed my friend")
rev9 = Review.find_or_create_by(user: user4, bar: bar3, rating: 2, content: "so much diarrhea...")

location = "houston"
offset = 0
limit = 50
api_url = "https://api.yelp.com/v3/businesses/search?location=#{location}&term=bars&limit=50&offset=#{offset}"
api_key = "Bearer ZCGB7cghN6Tbki6ojzII7FrWTpKUxQ3FRxvxjOG1YSBFZg7LS8TULAO6gQtFodUK1ku8xcImJBqvAlqS1uAN_zhmXxyH2TYb7qHhSrB77GASx8wH_WRJOrDMCzDOW3Yx"
headers = {
  "cache-control" => 'no-cache',
  "Authorization" => api_key
}


response = JSON.parse(RestClient.get(api_url, headers))

bars_array = response["businesses"]
bars_count = response["total"]
times_to_loop = (bars_count / limit) - 1
#binding.pry
for num in (1..times_to_loop)
  offset += 50
  response = JSON.parse(RestClient.get(api_url, headers))
  (bars_array << response["businesses"]).flatten!
end
binding.pry


