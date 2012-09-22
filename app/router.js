define([
  "app",
  "modules/editor"
],

function(app, Editor) {

  // Defining the application router, you can attach sub routers here.
  var Router = Backbone.Router.extend({
    routes: {
      "": "index"
    },

    index: function() {

      var list = new Editor.Site();

      app.useLayout("main").setViews({
        ".grid": new Backbone.View({
          template: "grid"
        })
      }).render();
    }
  });

  return Router;

});
