class GoalsController < ApplicationController

  def index
    @goals = Goals.for_user(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @goals }
    end
  end

  def create
    @goal = Goal.new(params.permit(:name, :target_date))
    @goal.user = current_user
    @goal.save!

    render json: @goal
  end

  def show
    
  end

  def update
    @goal = Goal.for_user(current_user).where(id: params.id) or not_found

    if params.permit(:name) then
      @goal.name = params.permit(:name)
    end
    if params.permit(:target_date) then
      @goal.target_date = params.permit(:target_date)
    end
    @goal.save!

    render json: @goal
  end

  def destroy
  end

end
