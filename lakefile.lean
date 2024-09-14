import Lake
open Lake DSL

require Colorized from git "https://github.com/axiomed/Colorized.lean.git"

package "Bench" where

lean_lib Bench where

lean_exe Bench.Example
