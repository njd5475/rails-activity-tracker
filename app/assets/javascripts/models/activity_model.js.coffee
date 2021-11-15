class ActivityModel extends Backbone.Model
  url: -> 
    "/activities/#{this.attributes.id}"
  
  initialize: ->

  #the current task is the task without an end time
  isCurrent: ->
    @get('end')?

@ActivityModel = ActivityModel