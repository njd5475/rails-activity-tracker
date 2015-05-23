class Activity < ActiveRecord::Base

  def self.todays
    where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
  end

  def self.active
    where(end: nil)
  end
end
