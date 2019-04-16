class GoalModel extends Backbone.Model
  url: =>
    _url = "/goals"
    if @attributes.id
      _url = "/goals/#{@attributes.id}"
    
    _url

  initialize: ->
  
@GoalModel = GoalModel