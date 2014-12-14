require "./ski.rb"

IOTA = SKICombinator.new('ι')

# ι[a] to a[S][K]
def IOTA.call(a)
  SKICall.new(SKICall.new(a, S), K)
end

class SKISymbol
  def to_iota
    self
  end
end

class SKICall
  def to_iota
    SKICall.new(left.to_iota, right.to_iota)
  end
end

def S.to_iota
  SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, IOTA))))
end

def K.to_iota
  SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, IOTA)))
end

def I.to_iota
  SKICall.new(IOTA, IOTA)
end
