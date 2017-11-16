class AddBudgetToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :budget, :integer
  end
end
