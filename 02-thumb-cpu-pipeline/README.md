# 02 — Pipelined Thumb CPU

A 4-stage (IF / ID / EX / WB) pipelined CPU for the 16-bit ARM Thumb
instruction set, without forwarding or hazard stalls. The course provided
a single-module pipelined core (`golden/thumb_ref.v`, by Sunggu Lee); the
project was to partition it into stage modules, synthesise and simulate
it at gate level.

| File | Content |
|---|---|
| `rtl/thumb_pipe.v` | top `thumb` + stage modules `IF`, `ID`, `EX`, `WB` |
| `golden/thumb_ref.v` | course core, module renamed `thumb_ref` (reference model) |
| `rtl/archive/` | two earlier partitionings |
| `syn/` | DC scripts, netlists for area / balanced / delay constraints, reports |

## Verification
* `make legacy` — the course program (a counting loop that must store
  `0x24` at `0x100`) on both cores.
* `make verif`
  * **lockstep differential test** (Verilator): both cores run the same
    random program from separate memories — every Thumb-1 format the cores
    decode plus 10 % random encodings, data memory random — and the
    testbench compares instruction address, memory strobes, addresses,
    store data, r0–r7 and N/Z/C/V **every cycle** (300 programs × 400
    cycles). Coverage: every internal opcode reaching EX and
    taken / not-taken per branch condition.
  * **4-state bus test** (Icarus): store → load → store round trip on a
    real tri-state data bus, with an X check on the bus during loads.

**[BUGS.md](BUGS.md)** — the data bus was never released (in the course
core too), and reset injected an `ADC`.
