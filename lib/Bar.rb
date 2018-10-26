require 'pry'
require_relative '../config/environment'

class Bar < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def self.gross_array
    ["roach", "roaches", "poo", "hobo", "rat", "rats", "feces", "vomit", "droppings", "cockroach", "cockroaches", "hepatitis", "heroin", "cocaine", "puke", "urine", "pee", "prostitute", "piss", "skank", "disease", "tabc", "swingers", "barf", "barfs"]
  end

  def self.nasty?(gross_word=nil)
    new_gross_array = self.gross_array
    new_gross_array = [gross_word.downcase] if gross_word

    gross_review_array = Review.all.select do | review |
      review_array = review.content.split(" ").collect do | word |
        word.downcase.gsub(/[^0-9A-Za-z]/,'')
      end
      !(review_array & new_gross_array).empty? && review.rating < 3
    end
    self.nasty_array_to_hash(gross_review_array)
  end

  def self.nasty_array_to_hash(gross_review_array)
    gross_review_hash = {}
    gross_review_array.each do | review |
      if !gross_review_hash[review.bar.name]
        gross_review_hash[review.bar.name] = [{"rating" => review.rating, "content" => review.content}]
      else
        gross_review_hash[review.bar.name] << {"rating" => review.rating, "content" => review.content}
      end
    end
    gross_review_hash
  end

end
