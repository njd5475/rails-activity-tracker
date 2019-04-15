class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user, index: true, foreign_key: false
      t.references :activities, index: true, foreign_key: false
      t.string :name
      t.date :target_date

      t.timestamps null: false
    end
  end
end
