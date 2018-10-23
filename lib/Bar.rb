require 'pry'
require_relative '../config/environment'

class Bar < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  def self.gross_problems?
    gross_stuff = ["roach", "roaches", "poo", "hobo", "rat", "rats"]
    rev_array = Review.all.select do | review |
      array = review.content.split(" ").collect do | word |
        word.downcase.gsub(/[^0-9A-Za-z]/,'')
      end
      !(array & gross_stuff).empty?
    end
    new_hash = {}
    rev_array.each do | review |
      if !new_hash[review.bar.name]
        new_hash[review.bar.name] = [review.content]
      else
        new_hash[review.bar.name] << review.content
      end
    end
    new_hash
  end

end
