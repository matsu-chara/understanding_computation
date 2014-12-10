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

INCREMENT = -> n { -> p { -> { p[n][p][x] } } }
SLIDE     = -> p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = -> n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

ADD       = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT  = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY  = -> m { -> n { n[ADD[m]][ZERO] } }
POWER     = -> m { -> n { n[MULTIPLY[m]][ONE] } }

# 答えが負の数になるような引き算をしても0が帰ってくることを利用している
IS_LESS_OR_EQUAL =
  -> m { -> n {
    IS_ZERO[SUBTRACT[m][n]]
} }

# 再帰版
# MOD =
#   -> m { -> n {
#     IF[IS_LESS_OR_EQUAL[m][n]][
#       -> x {
#         MOD[SUBTRACT[m][n]][n][x]
#       }
#     ][
#       m
#     ]
# } }

# 再帰使わない版
Z = -> f { -> x { f[->y { x[x][y] }] }[-> x {f[-> y { x[x][y] }] }] }
MOD =
  Z[->f {-> m { -> n {
    IF[IS_LESS_OR_EQUAL[m][n]][
      -> x {
        f[SUBTRACT[m][n]][n][x]
      }
    ][
      m
    ]
} } }]

# リスト
EMPTY = PAIR[TRUE][TRUE]
UNSHIFT = -> l { -> x {
            PAIR[FALSE][PAIR[x][l]]
          } }
IS_EMPTY = LEFT
FIRTST = -> l { LEFT[RIGHT[l]] }
REST = -> l { RIGHT[RIGHT[l]] }

def to_array(proc)
  array = []

  until to_boolean(IS_EMPTY[proc])
    array.push(FIRTST[proc])
    proc = REST[proc]
  end

  array
end

RANGE =
  Z[-> f {
    -> m { -> n {
      IF[IS_LESS_OR_EQUAL[m][n]][
        -> x {
          UNSHIFT[f[INCREMENT[m]][n]][m][x]
        }
      ][
        EMPTY
      ]
    } }
  }]

FOLD =
  Z[-> f {
    -> l { -> x { -> g {
      IF[IS_EMPTY[l]][
        x
      ][
        -> y {
          g[f[REST[l]][x][g]][FIRST[l]][y]
        }
      ]
    } } }
  }]

MAP =
  -> k { -> f {
  FOLD[k][EMPTY][
    -> l { -> x { UNSHIFT[l][f[x]] } }
  ]
} }
