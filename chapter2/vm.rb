require './number.rb'
require './bool.rb'
require './variable.rb'
require './nothing.rb'
require './assign.rb'

class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end

  def run
    while statement.reducible?
      puts "#{statement}, #{environment}"
      step
    end
    puts "#{statement}, #{environment}"
  end
end

# Machine.new(
#   Add.new(
#     Multiply.new(Number.new(1), Number.new(2)),
#     Multiply.new(Number.new(3), Number.new(4))
#   )
# ).run
#
# puts ""
# Machine.new(
#   LessThan.new(
#     Number.new(5),
#     Add.new(Number.new(2), Number.new(2))
#   )
# ).run
#
# puts ""
# Machine.new(
#   Add.new(Variable.new(:x), Variable.new(:y)),
#   { x: Number.new(3), y: Number.new(4) }
# ).run

puts ""
Machine.new(
  Assign.new(:x, Add.new(Variable.new(:x), Number.new(1))),
  { x: Number.new(2) }
).run
