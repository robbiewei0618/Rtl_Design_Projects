# Bug log — project 02

The refactored pipeline (`rtl/thumb_pipe.v`) is checked cycle-for-cycle
against the course core (`golden/thumb_ref.v`): 300 random programs ×
400 cycles with no divergence. The bugs below are the ones equivalence
checking alone could not see — both are in the course core too, or are
outside its steady state.

| # | Found by | Effect |
|---|----------|--------|
| 1 | 4-state bus test (`verif/tb_bus_4state.v`, Icarus) | every load read `X` bits: the CPU drove 0 onto the data bus while the memory drove the loaded word |
| 2 | reset assertion in the lockstep test | right after reset an `ADC r0` executed: `r0` became 0 and the flags changed before the first fetched instruction retired |

## 1. The CPU never released the data bus

```verilog
assign data = (~write_data_n) ? DR : 0;  // tri-state data
```

The comment says tri-state, the code drives 0. During a load the memory
drives the same wire, so every bit where the memory holds a 1 resolves to
`X`. `STR r1,[r0]; LDR r2,[r0]; STR r2,[r0,#4]` stored `000000XX` instead
of `0000005a`.

The course testbench never loads (its program only stores), and a 2-state
simulator such as Verilator silently resolves the conflict — which is why
the check is a small Icarus testbench: X/Z behaviour needs a 4-state
simulator. The same line is in the course core; `golden/thumb_ref.v` carries
the same one-line patch so that it can serve as the reference.

**Fix.** Drive `'z` when not writing.

## 2. Reset values encoded an `ADC`

The ID and EX pipeline registers reset their opcode to `6'b00_0000`, which
is the internal encoding of `ADC`. The first clock after reset therefore
executed `ADC r0` with zeroed operands: `r0 = 0` and N/Z/C/V updated, while
the register file should still hold its reset value (`0xFFFFFFFF`). Found
by an assertion that nothing retires in the first three cycles after
reset; programs that read `r0` or a flag before writing it would have seen
the wrong value.

**Fix.** Reset both opcode registers to `` `UNDEF ``, which the EX and WB
stages already treat as a bubble.

(The course core has no reset on IF_IR/ID at all, so after reset it
re-executes whatever instruction was in flight before; that is why the
lockstep comparison starts after a 9-instruction prologue that defines all
registers and flags.)
