define ["algorithms/union_find"], (UF) ->

  class Percolation
    # create N-by-N grid, with all sites blocked
    constructor: (n) ->
      @n = n                         # 5
      count = (n * n)                # 5*5 = 25 = 0..24

      @top = count                   # 25
      @bottom = count + 1            # 26

      @uf = new UF(count + 2)        # 25 + 2 = 0..26

      @sites = (new Int32Array(n) for [0..n-1])

    # open site (row i, column j) if it is not already
    # TODO: i and j should be > 0
    open: (i, j) ->
      return false if @isOpen(i, j)

      @sites[i][j] = 1
      n = @n

      ra = i - 1 # row above
      rc = j + 1 # right column
      rb = i + 1 # row bellow
      lc = j - 1 # left column

      as = n * i  + j
      ts = n * ra + j   # site above
      rs = n * i  + rc  # right site
      bs = n * rb + j   # site bellow
      ls = n * i  + lc  # left site

      @uf.union(as, ts) if @isOpen ra, j
      @uf.union(as, rs) if @isOpen i, rc
      @uf.union(as, bs) if @isOpen rb, j
      @uf.union(as, ls) if @isOpen i, lc

      @uf.union(as, @top) if i is 0

    # is site (row i, column j) open?
    isOpen: (i, j) ->
      if (0 <= i <= @n-1) and (0 <= j <= @n-1)
        return @sites[i][j] is 1

    # is site (row i, column j) full?
    isFull: (i, j) ->
      @isOpen(i, j) and @uf.connected(@top, @n*i+j)

    # does the system percolate?
    percolades: ->
      for x in [0..@n-1] by 1
        if @isFull(@n-1, x)
          @uf.union((@n*(@n-1)) + x, @bottom)
      @uf.connected @top, @bottom

  Percolation
