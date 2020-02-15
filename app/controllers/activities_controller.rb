class ActivitiesController < ApplicationController

  def index
    @todaysActivities = Activity.for_user(current_user).todays.collect do |a|
      prepareJson(a)
    end
    @history = Activity.for_user(current_user).old.order(created_at: :desc).collect do |a|
      prepareJson(a)
    end
    @goals = Goal.for_user(current_user).order(created_at: :desc).collect do |goal|
      h = goal.as_json
      h[:activity_count] = goal.activities.count
      h
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @todaysActivities}
    end
  end

  def prepareJson(a)
    h = a.as_json
    h[:stop] = stop_activity_path(a)
    h[:goals_url] = goals_path()
    h[:goal_url] = goal_path(a.goal) if a.goal
    h
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
    @activity = Activity.for_user(current_user).find(params[:id]) or not_found
    permitted = params.permit(:description, :start, :end, :goal_id)
    
    if permitted.has_key?(:description) then
      @activity.description = permitted[:description]
    end

    if permitted.has_key?(:start) then
      @activity.start = permitted[:start]
    end

    if permitted.has_key?(:end) then
      @activity.end = permitted[:end]
    end

    if permitted.has_key?(:goal_id) then
      @activity.goal = Goal.for_user(current_user).find permitted[:goal_id]
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
