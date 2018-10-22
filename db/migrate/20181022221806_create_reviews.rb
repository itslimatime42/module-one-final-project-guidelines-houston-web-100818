class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :bar
      t.belongs_to :user
      t.integer :rating
      t.text :content
      t.datetime :date
    end
  end
end
