class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :address
      t.string :relationship
      t.date :birth_date
      t.date :gift_holiday_1
      t.date :gift_holiday_2
      t.date :gift_holiday_3

      t.timestamps
    end
  end
end
