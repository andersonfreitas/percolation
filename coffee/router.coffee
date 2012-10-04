define ["app", "modules/percolation_renderer"], (app, PercolationRenderer) ->

  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      "": "index"

    index: ->
      app.useLayout("main").setViews
        ".editor": new PercolationRenderer.View()
      .render()

  Router
