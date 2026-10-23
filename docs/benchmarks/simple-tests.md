# simple/simple-tests — allocation, laziness, weak refs, finalisers

Sandmark's `benchmarks/simple-tests/` suite: small stdlib-only benchmarks covering
allocation, lazy evaluation, stacks, finalizers, and weak/ephemeron tables.

### alloc
- **Source:** sandmark `benchmarks/simple-tests/alloc.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `[iterations]`: default 1 000 000; each iteration allocates 1000 short-lived records.
- **Description:** Minor heap allocation rate benchmark: allocates tuples and small lists at high frequency.

### lists
- **Source:** sandmark `benchmarks/simple-tests/lists.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<type> <length> [multiplier]`: `type` is `int`, `float`, `int-tuple`, `float-tuple`, `string`, `record`, `float-array`, `int-array` or `int-option-array`. It builds `5000000 / length × multiplier` lists of `length` elements (multiplier default 1).
- **Description:** Builds lists of `length` elements of the given type, over and over. Construction is not tail-recursive, so stack depth equals `length`.

### stress
- **Source:** sandmark `benchmarks/simple-tests/stress.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<length> <percent_retain> [iterations]`: a live list of `length` refs; each iteration allocates 1001 records and keeps `percent_retain`% of them in the list (iterations default 25000).
- **Description:** Allocation stress test; exercises minor and major GC.

### lazylist
- **Source:** sandmark `benchmarks/simple-tests/lazylist.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<length> <iterations>`: builds and forces a chain of `length` lazies, `iterations` times.
- **Description:** Lazy list operations via `Lazy.t` suspension.

### lazy_primes
- **Source:** sandmark `benchmarks/simple-tests/lazy_primes.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `[nth]`: computes the `nth` prime with a lazy sieve (default 1).
- **Description:** Lazy sieve of Eratosthenes using `Lazy.t`-deferred streams.

### morestacks
- **Source:** sandmark `benchmarks/simple-tests/morestacks.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `[n]`: runs a 1M-call loop `n + 1` times (default 10 000).
- **Description:** A loop of 1M calls to a trivial function, repeated. No recursion and no allocation.

### stacks
- **Source:** sandmark `benchmarks/simple-tests/stacks.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<depth> <kind> [times]`: `kind` is `ints-small`, `ints-large`, `floats-small` or `floats-large`: a non-tail recursion `depth` deep with 1 or 16 int/float arguments, run `times` times (default 5000).
- **Description:** Stdlib `Stack` module push/pop under various patterns.

### finalise
- **Source:** sandmark `benchmarks/simple-tests/finalise.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<percent> [iterations]`: each iteration allocates 1001 records and registers `Gc.finalise` on `percent`% of them (iterations default 10000).
- **Description:** GC finalizer registration and invocation throughput (`Gc.finalise`).

### weakretain
- **Source:** sandmark `benchmarks/simple-tests/weakretain.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<percent> <size> [rounds]`: 10M records allocated per round, `percent`% of them stored in a `size`-slot `Weak.t` used as a ring (rounds default 1).
- **Description:** Weak pointer retention: allocates objects and checks how many survive GC through a `Weak.t` array.

### weak_htbl
- **Source:** sandmark `benchmarks/simple-tests/weak_htbl.ml`
- **Build:** ocamlopt (stdlib only); OCaml 5.x adaptation (see `SANDMARK_ADAPTATIONS.md`)
- **Args:** `<N>` — table size
- **Description:** Correctness and performance test for ephemeron-based hash tables (`Ephemeron.K{1,2,n}.Make`) versus regular `Hashtbl` and `Map`-backed tables. Note: `iter` was removed from Ephemeron modules in OCaml 5.x; the correctness assertions for weak tables now pass vacuously.

