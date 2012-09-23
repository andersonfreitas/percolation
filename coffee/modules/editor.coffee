define ["app", "modules/percolation"], (app, Percolation) ->

  Editor = app.module()

  Editor.View = Backbone.View.extend
    template: "grid"

    events:
      'click #create': 'onCreate'
      'click .site': 'openSite'
      'click #random': 'random'

    initialize: ->
      @size = 18
      @createGrid(@size)

    onCreate: ->
      @size = @$('#grid-size').val()
      @createGrid(@size)
      @render()

    createGrid: (size) ->
      @percolation = new Percolation(size)

    openSite: (e, x) ->
      site = $(e.currentTarget)

      @percolation.open(site.data('row'), site.data('col'))
      @render()

    random: ->
      @percolation = new Percolation(@size)
      for n in [0.. Math.round(Math.random()*10000000%@size*@size-1)]
        @percolation.open(Math.abs(Math.round(Math.random()*10000000%(@size-1))), Math.abs(Math.round(Math.random()*10000000%(@size-1))))
      @render()

    serialize: ->
      size: @size
      percolation: @percolation

  Editor
