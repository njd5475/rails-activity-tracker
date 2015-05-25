#= require ./activity_model

class ActivityCollection extends Backbone.Collection
  url: '/activities'
  model: ActivityModel

  initialize: ->

  getCurrent: ->
    # forward responsibility to determine if a task is current to model
    @find ((e)-> !e.isCurrent())

@ActivityCollection = ActivityCollection