define ["app", "modules/editor", "modules/percolation_renderer"], (app, Editor, PercolationRenderer) ->

  # Defining the application router, you can attach sub routers here.
  Router = Backbone.Router.extend
    routes:
      "": "index"
      "canvas": "canvas"

    index: ->
      app.useLayout("main").setViews
        ".editor": new Editor.View()
      .render()

    canvas: ->
      app.useLayout("main").setViews
        ".editor": new PercolationRenderer.View()
      .render()

  Router
