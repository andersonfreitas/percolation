define ["app"], (app) ->

  # Create a new module.
  Editor = app.module()

  # Default model.
  Editor.Site = Backbone.Model.extend({
    })

  # Default collection.
  Editor.Collection = Backbone.Collection.extend(model: Editor.Site)

  # Return the module for AMD compliance.
  Editor

