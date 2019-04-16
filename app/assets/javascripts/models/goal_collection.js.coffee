#= require ./base_collection
#= require ./goal_model

class GoalCollection extends BaseCollection
  url: '/goals'
  model: GoalModel

  initialize: -> 


@GoalCollection = GoalCollection