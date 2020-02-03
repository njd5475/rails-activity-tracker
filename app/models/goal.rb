class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :activities

  def self.for_user(user)
    where(user: user)
  end

  def self.todays
    where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
  end

  def self.old
    created = Activity.arel_table[:created_at]
    where(created.lt(Time.now.beginning_of_day))
  end
end
