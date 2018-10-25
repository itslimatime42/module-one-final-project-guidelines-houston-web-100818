class User < ActiveRecord::Base
  has_many :reviews
  has_many :bars, through: :reviews

  # method that returns user with the most bad ratings
  # def self.most_bad_ratings_user
  #   angry_user_array = Review.all.where("rating < '3'")
  #     binding.pry
  #
  # end

  def self.side_pieces
    reviews = Review.all.select do | review |
      words = review.content.split(" ")
      words.include?("sidepiece") || words.include?("sidepieces")
    end

    cheaters = reviews.map do | review |
      # binding.pry
      name = User.all.where(id: review[:user_id])[0][:name]
      bar = Bar.all.where(id: review[:bar_id])[0][:name]
      { name: name, recommendation: bar, review: review.content }
    end
  end

end
