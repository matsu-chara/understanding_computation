PAIR  = -> x { -> y { -> f { f[x][y] } } }
LEFT  = -> p { p[-> x { -> y { x } } ] }
RIGHT = -> p { p[-> x { -> y { y } } ] }

TAPE = -> l { -> m { -> r { -> b { PAIR[PAIR[l][m]][PAIR[r][b]] } } } }
TAPE_LEFT = -> t { LEFT[LEFT[t]] }
TAPE_MIDDLE = -> t { RIGHT[LEFT[t]] }
TAPE_RIGHT = -> t { LEFT[RIGHT[t]] }
TAPE_BLANK = -> t { RIGHT[RIGHT[t]] }

TAPE_WRITE = -> t { ->c { TAPE[TAPE[t]][c][TAPE_RIGHT[t]][TAPE[t]] } }
TAPE_MOVE_HEAD_RIGHT =
  -> t {
    TAPE[
      PUSH[TAPE_LEFT[t]][TAPE_MIDDLE[t]]
    ][
      IF[IS_EMPTY[TAPE_RIGHT[t]]][
        TAPE_BLANK[t]
    ][
      FIRST[TAPE_RIGHT[t]]
    ]
  ][
    IF[IS_EMPTY[TAPE_RIGHT[t]]][
      EMPTY
    ][
      REST[TAPE_RIGHT[t]]
    ]
  ][
    TAPE_BLANK[t]
  ]
}

