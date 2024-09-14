import Colorized
open Colorized

structure Bench :=
  acc : Nat
  _start : Nat
  N : Nat

namespace Bench

def new : Bench :=
  {
    acc := 0
    _start := 0
    N := 1000
  }

def stop (b : Bench) : IO Bench := do
  let now ← IO.monoNanosNow
  pure
      {
        acc := b.acc + (now-b._start)
        _start := 0
        N := b.N
      }

def start (b : Bench) : IO Bench := do
  let now ← IO.monoNanosNow
  pure
      {
        acc := b.acc
        _start := now
        N := b.N
      }

def overheadAvg : IO Nat := do
  let mut b := Bench.new
  for _ in [0:b.N] do
    b ← b.start
    b ← b.stop
  return b.acc / b.N

def report (b : Bench) (name : String) : IO Unit := do
  let avgNano := (b.acc / b.N) - (← overheadAvg)
  let msecs := avgNano / 1000000
  let secs := msecs / 1000

  let coloredNano := (Colorized.color Color.Magenta (Colorized.style Style.Bold s!"{avgNano}"))
  let coloredMsecs := (Colorized.color Color.Red (Colorized.style Style.Bold s!"{msecs}"))
  let coloredName := (Colorized.style Style.Bold s!"{name}")
  let iters := (Colorized.style Style.Underline s!"{b.N} iter")


  let s := s!"{coloredName}        {iters}     {coloredNano} ns/op  {coloredMsecs} ms/op  {secs} s/op"

  IO.println s

end Bench
