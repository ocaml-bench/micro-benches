let stack = Treiber_stack.create ()

let items_to_stack = int_of_string Sys.argv.(1)
let rounds = try int_of_string Sys.argv.(2) with _ -> 1

let () =
  for _ = 1 to rounds do
  let start = Unix.gettimeofday () in
  let producer = Domain.spawn (fun _ ->
      for a = 0 to items_to_stack do
        Treiber_stack.push stack a
      done)
  in
  Domain.spawn (fun _ ->
      let c = ref 0 in
      while !c < items_to_stack do
        match Treiber_stack.pop stack with None -> () | Some _ -> incr c
      done ;
      let duration = Unix.gettimeofday () -. start in
      if !c != items_to_stack then
        Printf.printf "Item was lost - only found %d items\n" !c
      else
        Printf.printf
          "Pushed and popped %d items in %f seconds = %f/ms per item\n"
          items_to_stack duration
          (1000.0 *. duration /. float_of_int items_to_stack))
  |> Domain.join |> ignore ;
  Domain.join producer
  done
