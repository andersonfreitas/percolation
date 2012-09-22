define ["app", "modules/site"], (app, Site) ->

  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      "": "index"

    index: ->
      list = new Site.Collection()
      app.useLayout("main").setViews
        ".grid": new Backbone.View(template: "grid")
      .render()

  Router
