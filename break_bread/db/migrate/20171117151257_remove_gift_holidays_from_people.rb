class RemoveGiftHolidaysFromPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :gift_holiday_1, :date
    remove_column :people, :gift_holiday_2, :date
    remove_column :people, :gift_holiday_3, :date
  end
end
