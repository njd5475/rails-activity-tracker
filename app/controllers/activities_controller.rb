class ActivitiesController < ApplicationController

  def index
    @todaysActivities = Activity.for_user(current_user).todays.collect do |a|
      h = a.as_json
      h[:stop] = stop_activity_path(a)
      h
    end
    @history = Activity.for_user(current_user).old.order(created_at: :desc).collect do |a|
      h = a.as_json
      h[:stop] = stop_activity_path(a) if a.active
      h
    end
    @goals = Goal.for_user(current_user)

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
    Activity.for_user(current_user).active.each do |a|
      a.end = Time.now
      a.save
    end

    @activity = Activity.new(params.permit(:description))
    @activity.user = current_user
    @activity.start = Time.now
    @activity.save!

    render json: @activity
  end

  def update
    @activity = Activity.for_user(current_user).where(id: params.id) or not_found
    permitted = params.permit(:description, :start, :end, :goal_id)
    
    if permitted.hasKey?(:description) then
      @activity.description = permitted[:description]
    end

    if permitted.hasKey?(:start) then
      @activity.start = permitted[:start]
    end

    if permitted.hasKey?(:end) then
      @activity.end = permitted[:end]
    end

    if permitted.hasKey?(:goal_id) then
      @activity.goal = Goal.for_user(current_user).where(id: params.goal_id)
    end

    @activity.save!

    render json: @activity
  end

  def show
    activity = Activity.for_user(current_user).find params[:id]

    render json: activity
  end

  def stop
    activity = Activity.for_user(current_user).find params[:id]
    activity.end = Time.now
    activity.save!

    render json: activity
  end
end
