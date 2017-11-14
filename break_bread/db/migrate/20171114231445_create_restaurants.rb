class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.string :url
      t.float :rating
      t.string :photo
      t.belongs_to :person

      t.timestamps
    end
  end
end
