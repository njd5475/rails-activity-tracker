class AddUserRefToActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :user, index: true, foreign_key: true
  end
end
