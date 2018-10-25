class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar

  

  def self.worst_date_ever
    dates = Review.all.where(rating: 1).select do | review |
      words = review.content.split(" ").collect do | word |
        word.downcase.gsub(/[^0-9A-Za-z]/,'')
      end
      words.include?("date") && !(words & Bar.gross_array).empty?
    end

    dates.collect do | date |
      name = User.all.where(id: date[:user_id])[0][:name]
      bar = Bar.all.where(id: date[:bar_id])[0][:name]
      { name: name, bar: bar, review: date.content }
    end
  end
end
