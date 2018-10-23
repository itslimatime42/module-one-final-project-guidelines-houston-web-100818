class User < ActiveRecord::Base
  has_many :reviews
  has_many :bars, through: :reviews

  #method that returns user with the most bad ratings
  def self.most_bad_ratings_user
    angry_user_array = Review.all.where(rating: 0)
      #binding.pry
    
  end

end
