open HolKernel Parse;
open examplesBinaryTheory;

open birExamplesBinaryTheory;
open birExamples2BinaryTheory;

val _ = new_theory "tutorial_lift";

bir_is_lifted_prog_def;
val blocks = (fst o listSyntax.dest_list o dest_BirProgram o snd o dest_eq o concl o EVAL) ``bir_add_reg_prog``;

val bl = (el 1)blocks;
fun get_n_stmts_of_block bl =
  1 +
  let val (_,sl,_) = (dest_bir_block) bl; in (length o fst o listSyntax.dest_list) sl end;

val n_blocks = length blocks;
val n_stmts = List.foldr (op+) 0 (List.map get_n_stmts_of_block blocks);

local

val blocks = (fst o listSyntax.dest_list o dest_BirProgram o snd o dest_eq o concl o EVAL) ``bprog_add_times_two``;
val n_blocks = length blocks;
val n_stmts = List.foldr (op+) 0 (List.map get_n_stmts_of_block blocks);


val blocks = (fst o listSyntax.dest_list o dest_BirProgram o snd o dest_eq o concl o EVAL) ``bprog_is_even_odd``;
val n_blocks = length blocks;
val n_stmts = List.foldr (op+) 0 (List.map get_n_stmts_of_block blocks);

in
end;


(el 1)blocks;
(el 2)blocks;
(el ((0x3c div 4)+1))blocks;
(el ((0x40 div 4)+1))blocks;
(el ((0x4c div 4)+1))blocks;

bir_add_reg_arm8_lift_THM;
bir_exec_to_addr_label_def;
bir_lifting_machinesTheory.arm8_bmr_rel_EVAL;
bir_inst_liftingTheory.bir_is_lifted_prog_MULTI_STEP_EXEC;

val _ = export_theory();
