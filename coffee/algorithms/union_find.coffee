define ->

  class UF
    constructor: (n) ->
      if n < 0 then throw new Exception("Illegal")

      @count = n
      @id = new Int32Array(n)
      @sz = new Int32Array(n)

      @sz[i] = i for i in [0..n]
      @id[i] = i for i in [0..n]

      this

    find: (p) ->
      # console.log "find(#{p})"
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

      if @sz[i] < @sz[j]
           @id[i] = j; @sz[j] += @sz[i]
      else @id[j] = i; @sz[i] += @sz[j]

      @count--

  UF
