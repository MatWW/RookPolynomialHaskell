# :chess_pawn: Rook Polynomial Solver

## :star2: Overview

A tiny project written in haskell for Functional Programming course. It enables user to provide m x n chessboard with frobidden
squares and returns its [rook polynomial](https://en.wikipedia.org/wiki/Rook_polynomial).

## :gear: How to use

After entering ghci and loading RookPolynomial.hs file, run **main** function. You will be asked to pass the path to the **.txt** file containing chessboard that you want to get a rook polynomial for.

Chessboard needs to be specified in a following way:

- each square is represented by a single number that is either 0 or 1
- 0 means that square is forbidden and 1 means that square is allowed
- each row is represented by line of 0s and 1s without any spaces

Example of correct input file:

```
1011
0110
0010
```

If chessboard is not given in an above format, application will not work properly.

Rook polynomial for a given chessboard will be printed in a terminal.

Example output:  
`"r(x) = 1 + 6*x^1 + 8*x^2 + 2*x^3"`

After printing rook polynomial program will finish.
