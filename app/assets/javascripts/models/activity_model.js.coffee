class ActivityModel extends Backbone.Model
  url: -> 
    return "/activities/#{this.attributes.id}" if this.attributes.id
    "/activities"
  
  initialize: ->

  #the current task is the task without an end time
  isCurrent: ->
    @get('end')?

@ActivityModel = ActivityModel