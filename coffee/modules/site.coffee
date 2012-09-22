define ["app"], (app) ->

  Site = app.module()

  Site.Model = Backbone.Model.extend({})

  Site.Collection = Backbone.Collection.extend(model: Site.Model)

  Site
