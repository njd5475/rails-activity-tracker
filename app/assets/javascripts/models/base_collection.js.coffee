
class BaseCollection extends Backbone.Collection
  getAll: =>
    @map (model, index) => model

@BaseCollection = BaseCollection