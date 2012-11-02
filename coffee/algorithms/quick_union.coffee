define ->

  class QuickUnion
    constructor: (n) ->
      if n < 0 then throw new Exception("Illegal")

      @count = n
      @id = new Uint32Array(n)

      @id[i] = i for i in [0..n]

      this

    find: (p) ->
      if p < 0 or p >= @id.length then throw new Exception("Out of bounds")

      while p != @id[p]
        p = @id[p]
      p

    connected: (p, q) ->
      @find(p) is @find(q)

    union: (p, q) ->
      # console.log "union(#{p}, #{q}) : length: #{@id.length}"
      i = @find p
      j = @find q

      return false if i is j

      @id[i] = j
      @count--

  QuickUnion
