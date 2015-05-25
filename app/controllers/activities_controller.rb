class ActivitiesController < ApplicationController

  def index
    @todaysActivities = Activity.todays

    respond_to do |format|
      format.html
      format.json { render json: @todaysActivities}
    end
  end

  # When creating a new activity it is important to grab all previous activities
  # that do not have end dates and set those end dates to now
  # there should only be a single end date but in the case there is another it
  # will end rather than continue to cause issues.
  def create
    Activity.active.each do |a|
      a.end = Time.now
      a.save
    end

    @activity = Activity.new(params.permit(:description))
    @activity.start = Time.now
    @activity.save!

    render json: @activity
  end


end
