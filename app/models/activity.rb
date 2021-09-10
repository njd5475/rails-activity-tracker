class Activity < ActiveRecord::Base
  validate :start_must_be_before_end_time
  belongs_to :user
  belongs_to :goal, optional: true

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

  def self.active
    where(end: nil)
  end

  def active
    return self.end == nil
  end

  def start_must_be_before_end_time
    return if start.nil? or self.end.nil?
    errors.add(:start, "must be before end time") unless start < self.end
  end

end
