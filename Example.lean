
import Bench
open Bench

def main : IO Unit := do
  let mut b := Bench.new
  for _ in [0:b.N] do
    b ← b.start
    b ← b.stop

  b.report "BenchmarkNoOp"
