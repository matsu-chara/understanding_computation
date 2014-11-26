require './number.rb'

TRUE  = -> x { -> y { x } }
FALSE = -> x { -> y { y } }

def to_boolean(proc)
  proc[true][false]
end

IF =
  -> b {
    -> x {
      -> y {
        b[x][y]
      }
    }
}
# -> b { b }} まで簡略化可能

IS_ZERO = -> n { n[-> x { FALSE }][TRUE] }

PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }
