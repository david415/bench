import Colorized
open Colorized

structure Bench :=
  acc : Nat
  _start : Nat
  N : Nat
  overhead : Nat
namespace Bench

def new : Bench :=
  {
    acc := 0
    _start := 0
    N := 1000
    overhead := 0
  }

def stop (b : Bench) : IO Bench := do
  let now ← IO.monoNanosNow
  pure
      {
        acc := b.acc + (now-b._start)
        _start := 0
        N := b.N
        overhead := b.overhead
      }

def start (b : Bench) : IO Bench := do
  let now ← IO.monoNanosNow
  pure
      {
        acc := b.acc
        _start := now
        N := b.N
        overhead := b.overhead
      }

def report (b : Bench) (name : String) : IO Unit := do
  let avg := b.acc / b.N
  let coloredAvg := (Colorized.color Color.Magenta (Colorized.style Style.Bold s!"{avg}"))
  let s := s!"{name}        {b.N} iter      {coloredAvg} ns/op"
  IO.println s

end Bench

