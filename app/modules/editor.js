define(["app"], function(app) {
  var Editor;
  Editor = app.module();
  Editor.Site = Backbone.Model.extend({});
  Editor.Collection = Backbone.Collection.extend({
    model: Editor.Site
  });
  return Editor;
});