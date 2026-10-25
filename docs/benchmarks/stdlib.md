# simple/stdlib — stdlib data-structure microbenchmarks

Sandmark's `benchmarks/stdlib/` suite: 10 single-file benchmarks covering core stdlib
data structures. Each takes `<bench_type> [args]` and dispatches to sub-benchmarks.

### array_bench
- **Source:** sandmark `benchmarks/stdlib/array_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <length> <iterations>`: `array_fold`, `array_forall` or `array_iter`, over an int array of `length` elements.
- **Description:** Array allocation, initialisation, map, sort, and iteration microbenchmarks.

### bytes_bench
- **Source:** sandmark `benchmarks/stdlib/bytes_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <iterations>`: `bytes_get`, `bytes_sub`, `bytes_blit`, `bytes_concat`, `bytes_iter`, `bytes_map`, `bytes_trim`, `bytes_index`, `bytes_contains` or `bytes_uppercase_ascii`.
- **Description:** Bytes buffer operations: blit, fill, sub, compare.

### string_bench
- **Source:** sandmark `benchmarks/stdlib/string_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <iterations>`: `string_get`, `string_sub`, `string_blit`, `string_concat`, `string_iter`, `string_map`, `string_trim`, `string_index`, `string_contains`, `string_uppercase_ascii`, `string_split_on_char`, `string_compare` or `string_equal`.
- **Description:** String operations: concat, contains, split, compare.

### map_bench
- **Source:** sandmark `benchmarks/stdlib/map_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <n> [rounds]`: `map_iter`, `map_add`, `map_add_duplicate`, `map_remove`, `map_fold`, `map_for_all`, `map_find` or `map_map`. `n` is an iteration count, except for `map_add` and `map_add_duplicate`, where it is the size of the map built; for those two, `rounds` (default 1) repeats the build.
- **Description:** Functional map (AVL tree) insert, lookup, fold, merge.

### set_bench
- **Source:** sandmark `benchmarks/stdlib/set_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <iterations>`: `set_fold`, `set_mem` or `set_add_rem`, on a set of 1000 ints.
- **Description:** Functional set insert, union, inter, diff.

### stack_bench
- **Source:** sandmark `benchmarks/stdlib/stack_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <iterations>`: `stack_fold` or `stack_push_pop`.
- **Description:** Stack push/pop operations.

### hashtbl_bench
- **Source:** sandmark `benchmarks/stdlib/hashtbl_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <n> [rounds]`: `int_replace1`, `int_find1`, `int_replace2`, `int_find2`, `caml_hash_int`, `caml_hash_tuple`, `hashtbl_iter`, `hashtbl_fold`, `hashtbl_add_resizing`, `hashtbl_add_sized`, `hashtbl_add_duplicate`, `hashtbl_remove`, `hashtbl_find` or `hashtbl_filter_map`. `n` is an iteration count, except for `hashtbl_add_resizing`, `hashtbl_add_sized` and `hashtbl_add_duplicate`, where it is the number of entries added; for those, `rounds` (default 1) repeats the build.
- **Description:** Hashtable add, find, replace, fold.

### pervasives_bench
- **Source:** sandmark `benchmarks/stdlib/pervasives_bench.ml`
- **Build:** ocamlopt (stdlib only)
- **Args:** `<bench_type> <iterations>`: `pervasives_{compare,equal}_{lists,ints,floats,strings}`.
- **Description:** Stdlib arithmetic and comparison functions.

### str_bench
- **Source:** sandmark `benchmarks/stdlib/str_bench.ml`
- **Build:** ocamlopt + `str.cmxa` (`-I +str str.cmxa`)
- **Args:** `<bench_type> <iterations>`: `str_regexp`, `str_string_match`, `str_search_forward`, `str_string_partial_match`, `str_global_replace` or `str_split`.
- **Description:** Regular expression operations from the `Str` library.

### big_array_bench
- **Source:** sandmark `benchmarks/stdlib/big_array_bench.ml`
- **Build:** ocamlopt; links `bigarray.cmxa` only on OCaml 4.x (bundled into stdlib on 5.x)
- **Args:** `<bench_type> <length> <iterations>`: `big_array_int_rev` or `big_array_int32_rev`: reverses a Bigarray of `length` elements, `iterations` times.
- **Description:** Bigarray allocation and element access patterns.

