class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :description
      t.timestamp :start
      t.timestamp :end

      t.timestamps null: false
    end
  end
end
