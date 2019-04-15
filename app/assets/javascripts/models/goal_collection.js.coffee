#= require ./goal_model

class GoalCollection extends Backbone.Collection
  url: '/goals'
  model: GoalModel

  initialize: ->


@GoalCollection = GoalCollection