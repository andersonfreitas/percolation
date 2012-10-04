define ["app", "algorithms/percolation"], (app, Percolation) ->

  PercolationRenderer = app.module()

  PercolationRenderer.View = Backbone.View.extend
    template: 'canvas'

    fillColor: '#59aef6'

    events:
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

      @gui = new dat.GUI('width': 260, autoPlace: false)
      @gui.add(this, 'random')
      @gui.add(this, 'reset')

      sizeHandler = @gui.add(this, 'size', 2, 600)
      sizeHandler.onChange (value) =>
        if (@size = Math.round(@size)) % 2 == 1
          @size += 1
        @reset()

      fillColorHandler = @gui.addColor(this, 'fillColor')
      fillColorHandler.onChange (value) =>
        @draw()


    reset: ->
      @createGrid(@size)
      @draw()

    random: ->
      @percolation = new Percolation(@size)
      for n in [0.. Math.round(Math.random()*10000000%@size*@size-1)]
        @percolation.open(Math.abs(Math.round(Math.random()*10000000%(@size-1))), Math.abs(Math.round(Math.random()*10000000%(@size-1))))
      @draw()

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

          @ctx.fillStyle = "#191919"
          if @percolation.isOpen(i, j)
            @ctx.fillStyle = "white"
          if @percolation.isFull(i, j)
            @ctx.fillStyle = @fillColor

          @ctx.fillRect(x, y, w, h)

      @ctx.font = "normal 36px Verdana";
      @ctx.fillStyle = "yellow"

      if @percolation.percolades()
        @ctx.fillText "percolates", 100, 100
      else
        @ctx.fillText "does not percolates", 100, 100

    afterRender: ->
      @el.appendChild(@gui.domElement)
      @$('.close-button').remove()
      @canvas = @$('#grid')[0]
      @getContext()
      @draw()

  PercolationRenderer
