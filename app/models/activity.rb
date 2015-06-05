class Activity < ActiveRecord::Base
  belongs_to :user

  def self.for_user(user)
    where(user: user)
  end

  def self.todays
    where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
  end

  def self.active
    where(end: nil)
  end
end
