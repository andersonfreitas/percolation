define ->

  class UF
    constructor: (n) ->
      if n < 0 then throw new Exception("Illegal")

      @count = n
      @id = new Uint32Array(n)
      @sz = new Uint32Array(n)

      for i in [0..n] by 1
        @id[i] = i
        @sz[i] = 1

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
