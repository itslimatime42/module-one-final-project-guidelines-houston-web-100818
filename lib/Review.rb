class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar



  def self.worst_date_ever
    dates = Review.all.where(rating: 1).select do | review |
      words = review.content.split(" ")
      words.include?("date") #&& !(words & Bar.gross_array).empty?
    end
  end
end
