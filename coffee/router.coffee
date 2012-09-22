define ["app", "modules/site", "modules/editor"], (app, Site, Editor) ->

  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      "": "index"

    index: ->
      list = new Site.Collection()
      app.useLayout("main").setViews
        ".editor": new Editor.View()
      .render()

  Router
