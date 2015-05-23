class ActivitiesController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: Activity.todays}
    end
  end

  def create
    @activity = Activity.new(params.permit(:description))
    @activity.start = Time.now
    @activity.save!

    render json: @activity
  end

end
