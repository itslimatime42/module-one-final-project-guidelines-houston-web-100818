class CreateBars < ActiveRecord::Migration[5.0]
  def change
    create_table :bars do |t|
      t.string :name
      t.string :category
      t.string :city
      t.string :url
    end
  end
end
