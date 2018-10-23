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