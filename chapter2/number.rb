class Number < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?()
      false
  end
end

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?()
      true
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value + right.value)
    end
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?()
      true
  end

  def reduce(environment)
    if left.reducible?
      Add.new(left.reduce(environment), right)
    elsif right.reducible?
      Add.new(left, right.reduce(environment))
    else
      Number.new(left.value * right.value)
    end
  end
end

# 抽象構文木(AST)の手動構築
# （）をつけたりしないので、出力された式は必ずしも正しくない。
# p Add.new(
#   Multiply.new(Number.new(1), Number.new(2)),
#   Multiply.new(Number.new(3), Number.new(4))
# )

# 簡約可能かどうか
# p Number.new(1).reducible?
# p Add.new(Number.new(1), Number.new(2)).reducible?

# 簡約実行
# e =  Add.new(
#   Multiply.new(Number.new(1), Number.new(2)),
#   Multiply.new(Number.new(3), Number.new(4))
# )
# p e
# p e.reducible?
# e = e.reduce
#
# p e
# p e.reducible?
# e = e.reduce
#
# p e
# p e.reducible?
# e = e.reduce
#
# p e
# p e.reducible?
