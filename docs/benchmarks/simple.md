# simple/ — stdlib-only sequential benchmarks

Stdlib- and unix-only sequential benchmarks, one binary each. Most are the classic sandmark set; `capi/` is the odd one out (mixed OCaml/C). 24 programs.

The arguments each program is run with are in `manifest.yml`.

### markbench

- **Source:** sandmark `benchmarks/markbench/`
- **Build:** dune + `unix`
- **Args:** _(none)_ — defaults to 10 `Gc.full_major` cycles; pass an integer to override
- **Description:** Microbenchmark for the major GC mark phase. Allocates a large live set and calls `Gc.full_major` repeatedly, measuring seconds per GC cycle. Sensitive to `o` (space overhead) and `s` (minor heap size).

### minilight

- **Source:** sandmark `benchmarks/multicore-minilight/sequential/`
- **Build:** dune (stdlib only, multi-file), in `simple/minilight/`
- **Args:** `<scene-file>` — absolute path to `roomfront.ml.txt`; use `$RUNNING_BENCH_DIR/simple/minilight/roomfront.ml.txt`
- **Description:** Sequential MiniLight 1.5.2 global illumination renderer. Traces rays through a Cornell box scene using an octree spatial index; exercises float arithmetic, object-oriented style (classes), and moderate allocation. The sandmark dune listed `domainslib` but the sequential sources do not use it.
- **Note:** The parallel version is `multicore/multicore-minilight/minilight_multicore`.

### almabench

- **Source:** sandmark `benchmarks/almabench/` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[loops]`: passes over the 36525-day, 8-planet simulation (default 5).
- **Description:** Floating-point benchmark computing energy levels of a quantum-mechanical system. Exercises the minor heap heavily with small float arrays.

### bdd

- **Source:** sandmark `benchmarks/bdd/` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[n] [ntests] [rounds]`: builds the hidden-weighted-bit BDD over `n` variables (default 22), checks it on `ntests` random inputs (default 100), and does all of that `rounds` times (default 1).
- **Description:** Binary Decision Diagram operations (AND, OR, NOT, quantification) on propositional formulae. Pointer-heavy graph structure; exercises major GC and sharing.

### hamming

- **Source:** sandmark `benchmarks/hamming/`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<N> [rounds]`: number of Hamming numbers to iterate over; `rounds` (default 1) rebuilds the stream and walks it again, printing only in the last round.
- **Description:** Generates the infinite lazy Hamming sequence (numbers of the form 2^i × 3^j × 5^k) using lazy streams and lazy merging. Exercises lazy allocation and minor GC.

### soli

- **Source:** sandmark `benchmarks/soli/`
- **Build:** ocamlopt (stdlib only)
- **Args:** `[nruns]`: number of solver runs (default 1).
- **Description:** Peg solitaire solver using backtracking search. Exercises call stack and moderate allocation; useful for testing the interaction between recursion depth and minor heap pressure.

### kb

- **Source:** sandmark `benchmarks/kb/` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[passes]`: Knuth-Bendix completion passes (default 100).
- **Description:** Knuth-Bendix completion procedure (with exceptions). Algebraic term rewriting; heavily allocates and collects term structures. A classic OCaml GC benchmark.

### kb_no_exc

- **Source:** sandmark `benchmarks/kb/kb_no_exc.ml` (shares directory with `kb`)
- **Build:** ocamlopt (stdlib only) — build script is `kb_no_exc.build.sh` in `simple/kb/`
- **Args:** `[passes]`: Knuth-Bendix completion passes (default 100).
- **Description:** Same algorithm as `kb` but with the exception-based search replaced by an explicit option type. Useful for comparing exception overhead against allocation/GC cost.

### lexifi-g2pp

- **Source:** sandmark `benchmarks/lexifi-g2pp/` (originally OCamlPro's ocamlbench-repo)
- **Build:** dune (stdlib only, multi-file; entry point: `main.exe`)
- **Args:** _(none)_
- **Description:** Calibrates a G2++ two-factor interest rate model (LexiFi's financial library benchmark). Involves iterative numerical optimisation over a large structured dataset. Exercises both arithmetic and moderate allocation in a realistic workload.

### zdd

- **Source:** sandmark `benchmarks/zdd/`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<words-file>` — absolute path to `words.txt`; use `$RUNNING_BENCH_DIR/simple/zdd/words.txt`
- **Description:** Zero-suppressed Binary Decision Diagram (ZDD) operations over an English word dictionary. Builds a ZDD from all words, then counts matches for a pattern query. Exercises pointer-heavy DAG structures similar to `bdd`.
- **Note:** The run cwd is a temp dir, so the word file must be passed as an absolute path.

### fannkuchredux

- **Source:** sandmark `benchmarks/benchmarksgame/fannkuchredux.ml`
- **Build:** ocamlopt (stdlib only), compiled with `-noassert -unsafe` as in sandmark
- **Args:** `<N>`: permutation length.
- **Description:** Counts the maximum number of flips needed to sort a permutation, and sums the sign of each intermediate permutation (Pfannkuchen benchmark). Pure computation with no allocation; useful as a control benchmark where GC has negligible impact.

### numerical-analysis

Six benchmarks sharing `simple/numerical-analysis/`. Each has its own build script; two require two source files compiled in order.

#### crout_decomposition

- **Source:** sandmark `benchmarks/numerical-analysis/crout_decomposition.ml` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[rounds]`: repeats the whole decomposition (default 1).
- **Description:** Crout matrix decomposition (LU factorisation variant) on a fixed matrix. Dense linear algebra; exercises float array allocation.

#### qr_decomposition

- **Source:** sandmark `benchmarks/numerical-analysis/qr_decomposition.ml` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[rounds]`: repeats the whole decomposition (default 1).
- **Description:** QR decomposition via Gram-Schmidt on a fixed matrix. Dense linear algebra; similar allocation profile to `crout_decomposition`.

#### durand_kerner_aberth

- **Source:** sandmark `benchmarks/numerical-analysis/durand_kerner_aberth.ml` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `[percent] [passes]`: percentage of the coefficient array to use (default 100; it can only shrink the problem) and number of root-finding passes (default 10).
- **Description:** Finds all roots of a polynomial simultaneously using the Durand–Kerner / Weierstrass method. Complex-number arithmetic on float arrays.

#### fft

- **Source:** sandmark `benchmarks/numerical-analysis/fft.ml` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt + `unix.cmxa` (uses `Unix.times` for timing output)
- **Args:** `[size] [rounds]`: array size (default 1048576); `rounds` repeats the FFT and inverse FFT (default 1).
- **Description:** Cooley–Tukey FFT followed by inverse FFT on a complex float array. In-place computation; exercises large float array allocation and cache effects.

#### levinson_durbin

- **Source:** sandmark `benchmarks/numerical-analysis/levinson_durbin.ml` + `levinson_durbin_dataset.ml`
- **Build:** ocamlopt (stdlib only), two-file: dataset compiled first
- **Args:** `[order] [rounds]`: AR order (default 10000); `rounds` repeats the work over all five datasets (default 1).
- **Description:** Levinson–Durbin recursion for autoregressive modelling of Japanese vowel sound data. Exercises float array allocation with a real-world-sized numerical dataset.

#### naive_multilayer

- **Source:** sandmark `benchmarks/numerical-analysis/naive_multilayer.ml` + `naive_multilayer_dataset.ml`
- **Build:** ocamlopt (stdlib only), two-file: dataset compiled first
- **Args:** `[rounds]`: repeats the training (default 1).
- **Description:** Naive multilayer neural network (forward pass + backpropagation) on the UCI Ionosphere dataset. Dense matrix operations; exercises both float array allocation and functional list structure.

### sequence_cps

- **Source:** sandmark `benchmarks/sequence/sequence_cps.ml` (originally OCamlPro's ocamlbench-repo)
- **Build:** ocamlopt (stdlib only)
- **Args:** `<N>`: sequence length.
- **Description:** Builds a lazy CPS-style sequence of integers 0…N, then maps, filters, and folds it to compute a sum. Exercises higher-order function application and minor heap allocation in a functional pipeline; no external libraries required.


### capi

- **Source:** sandmark `benchmarks/simple-tests/ocamlcapi.{ml,c}` + `capi.ml`
- **Build:** dune, mixed OCaml/C (`foreign_stubs`)
- **Args:** `<test_name> <iterations>`: number of calls.
- **Description:** Measures the cost of the OCaml → C calling convention itself.
  Six programs cross three argument counts (`no_args`, `few_args`, `many_args` —
  the last crosses the 5-argument boundary that forces the bytecode/native pair)
  against two allocation modes (`alloc` vs an `[@@noalloc]` stub). Each C
  function does essentially nothing, so what you are timing is the transition:
  frame setup, `caml_c_call`, and — for the `alloc` variants — the young-pointer
  and root bookkeeping that `[@@noalloc]` skips. The pairwise difference
  `alloc − noalloc` at a fixed argument count is the interesting number.
- **Programs:** `capi_no_args_alloc`, `capi_no_args_noalloc`,
  `capi_few_args_alloc`, `capi_few_args_noalloc`, `capi_many_args_alloc`,
  `capi_many_args_noalloc`
