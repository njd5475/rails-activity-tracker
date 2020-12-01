class AddColumnsToGoal < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :target_value, :string
    add_column :goals, :default_value, :string
    add_column :goals, :current_value, :string
  end
end
