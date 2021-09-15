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

  def duration
    self.activities.joins(:goal).select(Goal.arel_table['name']).select("(\"activities\".\"end\" - \"activities\".\"start\") as duration").where.not(end: nil, start: nil).sum(&:duration)
  rescue => e
    return 0
  end

  def self.invalid_activities
    self.joins(:activities).where(Activity.arel_table['end'].lt(Activity.arel_table['start']))
  end

end
