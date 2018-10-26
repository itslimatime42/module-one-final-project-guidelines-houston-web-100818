class User < ActiveRecord::Base
  has_many :reviews
  has_many :bars, through: :reviews

  def self.angriest_user_reviews
    angriest_user_id_count = Review.all.where(rating: 1).group("user_id").count("user_id").max_by{|k, v| v}

    angriest_user_id = angriest_user_id_count[0]
    review_count = angriest_user_id_count[1]
    angriest_user_name = User.all.where(id: angriest_user_id)[0][:name]
    angry_reviews = Review.all.where(user_id: angriest_user_id, rating: 1)
    angry_reviews_array = angry_reviews.map do |review| 
      {Bar.all.where(id: review[:bar_id])[0][:name] => review[:content]}
    end
    angry_hash = {name: angriest_user_name, count: review_count, reviews: angry_reviews_array}
  end


  def self.side_pieces
    reviews = Review.all.select do | review |
      words = review.content.split(" ")
      words.include?("sidepiece") || words.include?("sidepieces")
    end

    cheaters = reviews.map do | review |
      name = User.all.where(id: review[:user_id])[0][:name]
      bar = Bar.all.where(id: review[:bar_id])[0][:name]
      { name: name, bar: bar, review: review.content }
    end
  end

end
