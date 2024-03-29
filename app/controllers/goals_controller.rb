class GoalsController < ApplicationController

  def index
    @goals = Goal.for_user(current_user).collect do |goal|
      jsonGoal = goal.as_json
      jsonGoal[:activities_url] = goal_activities_path(goal)
      jsonGoal[:duration] = goal.duration
      jsonGoal
    end

    respond_to do |format|
      format.html
      format.json { render json: @goals }
    end
  end

  def create
    @goal = Goal.new(params.permit(:name, :target_date, :target_value, :default_value, :current_value))
    @goal.user = current_user
    @goal.save!

    render json: @goal
  end

  def show
    @goal = Goal.for_user(current_user).find params[:id]

    render json: @goal
  end

  def update
    @goal = Goal.for_user(current_user).find(params[:id]) or not_found
    permitted = params.permit(:name, :target_date, :target_value, :current_value)

    if permitted.has_key?(:name) then
      @goal.name = permitted[:name]
    end
    
    if permitted.has_key?(:target_date) then
      @goal.target_date = permitted[:target_date]
    end
    
    if permitted.has_key?(:target_value) then
      @goal.target_value = permitted[:target_value]
    end
    
    if permitted.has_key?(:current_value) then
      @goal.current_value = permitted[:current_value]
    end
    
    @goal.save!

    render json: @goal
  end

  def destroy
    @goal = Goal.for_user(current_user).where(id: params.require(:id)) or not_found

    @goal.destroy_all

    render json: { success: true }.to_json
  end

end
