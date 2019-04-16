#= require ./base_collection
#= require ./activity_model

class ActivityCollection extends BaseCollection
  url: '/activities'
  model: ActivityModel

  initialize: ->

  getCurrent: ->
    # forward responsibility to determine if a task is current to model
    @find ((e)-> !e.isCurrent())

@ActivityCollection = ActivityCollection