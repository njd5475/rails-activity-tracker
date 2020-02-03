class ChangeGoalToActivityRelation < ActiveRecord::Migration[6.0]
  def change
    remove_column :goals, :activities_id
    add_reference :activities, :goal, index: true 
  end
end
