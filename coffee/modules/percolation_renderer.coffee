define ["app", "modules/percolation"], (app, Percolation) ->

  PercolationRenderer = app.module()

  PercolationRenderer.View = Backbone.View.extend
    template: 'canvas'

    events:
      'click #create': 'onCreate'
      'click #random': 'random'
      'click #grid': 'openSite'

      'mousedown #grid': 'startDraw'
      'mousemove #grid': 'drawSite'
      'mouseup #grid': 'endDraw'

    startDraw: ->
      @drawing = true
    endDraw: ->
      @drawing = false
    drawSite: (e) ->
      if @drawing
        @openSite(e)

    initialize: ->
      @size = 50
      @createGrid(@size)

    onCreate: ->
      @size = @$('#grid-size').val()
      @createGrid(@size)
      @draw()

    random: ->
      @percolation = new Percolation(@size)
      for n in [0.. Math.round(Math.random()*10000000%@size*@size-1)]
        @percolation.open(Math.abs(Math.round(Math.random()*10000000%(@size-1))), Math.abs(Math.round(Math.random()*10000000%(@size-1))))
      @render()

    getContext: ->
      @canvas.width = 600
      @canvas.height = 600 #window.innerHeight
      @ctx = @canvas.getContext('2d')

    clearScreen: ->
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height)

    createGrid: (size) ->
      @percolation = new Percolation(size)

    serialize: ->
      size: @size

    openSite: (e) ->
      w = @canvas.width / @size

      j = Math.floor(e.offsetX / w)
      i = Math.floor(e.offsetY / w)

      @percolation.open(i, j)
      @draw()

    draw: ->
      @clearScreen()
      w = @canvas.width / @size
      h = @canvas.height / @size

      for i in [0 .. @size]
        for j in [0 .. @size]
          x = j * w
          y = i * h

          @ctx.fillStyle = "black"
          if @percolation.isOpen(i, j)
            @ctx.fillStyle = "white"
          if @percolation.isFull(i, j)
            @ctx.fillStyle = "#59aef6"

          @ctx.fillRect(x, y, w, h)

    afterRender: ->
      @canvas = @$('#grid')[0]
      @getContext()
      @draw()

  PercolationRenderer
