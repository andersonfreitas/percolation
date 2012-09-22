define ["app", "modules/editor"], (app, Editor) ->
  
  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend(
    routes:
      "": "index"

    index: ->
      list = new Editor.Site()
      app.useLayout("main").setViews(".grid": new Backbone.View(template: "grid")).render()
  )
  Router

