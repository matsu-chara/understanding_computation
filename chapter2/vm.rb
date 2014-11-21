require './number.rb'
require './bool.rb'

class Machine < Struct.new(:expression)
  def step
    self.expression = expression.reduce
  end

  def run
    while expression.reducible?
      puts expression
      step
    end
    puts expression
  end
end

Machine.new(
  Add.new(
    Multiply.new(Number.new(1), Number.new(2)),
    Multiply.new(Number.new(3), Number.new(4))
  )
).run

puts ""

Machine.new(
  LessThan.new(
    Number.new(5),
    Add.new(Number.new(2), Number.new(2))
  )
).run
