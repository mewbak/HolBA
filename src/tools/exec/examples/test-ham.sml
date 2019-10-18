open HolKernel Parse bossLib boolLib;
open bslSyntax;

open bir_execLib;

open bir_ppLib;

val _ = install_bir_pretty_printers();

val _ = Parse.current_backend := PPBackEnd.vt100_terminal;



val _ = print "Loading program... ";

val prog_ldld_w_obs_full = ("prog_ldld_w_obs", ``
BirProgram
      [<|bb_label := BL_Address (Imm64 0w);
         bb_statements :=
           [BStmt_Assign (BVar "ProcState_C" (BType_Imm Bit1))
              (BExp_BinPred BIExp_LessOrEqual (BExp_Const (Imm64 0xCA2000w))
                 (BExp_Den (BVar "R0" (BType_Imm Bit64))));
            BStmt_Assign (BVar "ProcState_N" (BType_Imm Bit1))
              (BExp_BinPred BIExp_SignedLessThan
                 (BExp_BinExp BIExp_Minus
                    (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 0xCA2000w))) (BExp_Const (Imm64 0w)));
            BStmt_Assign (BVar "ProcState_V" (BType_Imm Bit1))
              (BExp_BinPred BIExp_Equal
                 (BExp_BinPred BIExp_SignedLessThan
                    (BExp_BinExp BIExp_Minus
                       (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 0xCA2000w)))
                    (BExp_Const (Imm64 0w)))
                 (BExp_BinPred BIExp_SignedLessOrEqual
                    (BExp_Const (Imm64 0xCA2000w))
                    (BExp_Den (BVar "R0" (BType_Imm Bit64)))));
            BStmt_Assign (BVar "ProcState_Z" (BType_Imm Bit1))
              (BExp_BinPred BIExp_Equal
                 (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                 (BExp_Const (Imm64 0xCA2000w)));
            BStmt_Assign (BVar "R15" (BType_Imm Bit64))
              (BExp_BinExp BIExp_Minus
                 (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                 (BExp_Const (Imm64 0xCA2000w)))];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 4w)))|>;
       <|bb_label := BL_Address (Imm64 4w); bb_statements := [];
         bb_last_statement :=
           BStmt_CJmp (BExp_Den (BVar "ProcState_V" (BType_Imm Bit1)))
             (BLE_Label (BL_Address (Imm64 40w)))
             (BLE_Label (BL_Address (Imm64 8w)))|>;
       <|bb_label := BL_Address (Imm64 8w);
         bb_statements :=
           [BStmt_Assert
              (BExp_BinPred BIExp_Equal
                 (BExp_BinExp BIExp_And
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 7w))) (BExp_Const (Imm64 0w)));
            BStmt_Assert
              (BExp_BinExp BIExp_And
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Const (Imm64 0x80100000w))
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 504w))))
                 (BExp_BinPred BIExp_LessThan
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 504w)))
                    (BExp_Const (Imm64 0x8013FF80w))));
            BStmt_Assign (BVar "R5" (BType_Imm Bit64))
              (BExp_Load (BExp_Den (BVar "MEM" (BType_Mem Bit64 Bit8)))
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 504w))) BEnd_LittleEndian Bit64);
            BStmt_Observe (BExp_Const (Imm1 1w))
              [BExp_BinExp BIExp_RightShift
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 504w))) (BExp_Const (Imm64 6w))] HD;
            BStmt_Assert
              (BExp_BinExp BIExp_And
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Const (Imm64 0x80100000w))
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 512w))))
                 (BExp_BinPred BIExp_LessThan
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 512w)))
                    (BExp_Const (Imm64 0x8013FF80w))));
            BStmt_Assign (BVar "R15" (BType_Imm Bit64))
              (BExp_Load (BExp_Den (BVar "MEM" (BType_Mem Bit64 Bit8)))
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 512w))) BEnd_LittleEndian Bit64);
            BStmt_Observe (BExp_Const (Imm1 1w))
              [BExp_BinExp BIExp_RightShift
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 512w))) (BExp_Const (Imm64 6w))] HD];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 12w)))|>;
       <|bb_label := BL_Address (Imm64 12w); bb_statements := [];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 16w)))|>;
       <|bb_label := BL_Address (Imm64 16w); bb_statements := [];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 40w)))|>;
       <|bb_label := BL_Address (Imm64 20w);
         bb_statements :=
           [BStmt_Assert
              (BExp_BinExp BIExp_And
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Const (Imm64 0x80100000w))
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_BinExp BIExp_LeftShift
                          (BExp_Den (BVar "R5" (BType_Imm Bit64)))
                          (BExp_Const (Imm64 0w)))))
                 (BExp_BinPred BIExp_LessThan
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                       (BExp_BinExp BIExp_LeftShift
                          (BExp_Den (BVar "R5" (BType_Imm Bit64)))
                          (BExp_Const (Imm64 0w))))
                    (BExp_Const (Imm64 0x8013FF80w))));
            BStmt_Assign (BVar "R18" (BType_Imm Bit64))
              (BExp_Cast BIExp_UnsignedCast
                 (BExp_Cast BIExp_SignedCast
                    (BExp_Load (BExp_Den (BVar "MEM" (BType_Mem Bit64 Bit8)))
                       (BExp_BinExp BIExp_Plus
                          (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                          (BExp_BinExp BIExp_LeftShift
                             (BExp_Den (BVar "R5" (BType_Imm Bit64)))
                             (BExp_Const (Imm64 0w)))) BEnd_LittleEndian Bit8)
                    Bit32) Bit64);
            BStmt_Observe (BExp_Const (Imm1 1w))
              [BExp_BinExp BIExp_RightShift
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R18" (BType_Imm Bit64)))
                    (BExp_BinExp BIExp_LeftShift
                       (BExp_Den (BVar "R5" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 0w)))) (BExp_Const (Imm64 6w))] HD];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 24w)))|>;
       <|bb_label := BL_Address (Imm64 24w);
         bb_statements :=
           [BStmt_Assert
              (BExp_BinExp BIExp_And
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                       (BExp_Den (BVar "R15" (BType_Imm Bit64))))
                    (BExp_Const (Imm64 0xFFFFFFFFFFFFFFFEw)))
                 (BExp_BinExp BIExp_And
                    (BExp_BinExp BIExp_Or
                       (BExp_BinPred BIExp_LessThan (BExp_Const (Imm64 0w))
                          (BExp_BinExp BIExp_Plus
                             (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                             (BExp_Den (BVar "R15" (BType_Imm Bit64)))))
                       (BExp_BinPred BIExp_LessOrEqual
                          (BExp_BinExp BIExp_Plus (BExp_Const (Imm64 1w))
                             (BExp_BinExp BIExp_Plus
                                (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                                (BExp_Den (BVar "R15" (BType_Imm Bit64)))))
                          (BExp_Const (Imm64 0w))))
                    (BExp_BinExp BIExp_Or
                       (BExp_BinPred BIExp_LessThan
                          (BExp_BinExp BIExp_Plus
                             (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                             (BExp_Den (BVar "R15" (BType_Imm Bit64))))
                          (BExp_Const (Imm64 0w)))
                       (BExp_BinPred BIExp_LessOrEqual
                          (BExp_Const (Imm64 40w))
                          (BExp_BinExp BIExp_Plus
                             (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                             (BExp_Den (BVar "R15" (BType_Imm Bit64))))))));
            BStmt_Assert
              (BExp_BinExp BIExp_And
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Const (Imm64 0x80100000w))
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                       (BExp_Den (BVar "R15" (BType_Imm Bit64)))))
                 (BExp_BinPred BIExp_LessThan
                    (BExp_BinExp BIExp_Plus
                       (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                       (BExp_Den (BVar "R15" (BType_Imm Bit64))))
                    (BExp_Const (Imm64 0x8013FF80w))));
            BStmt_Assign (BVar "MEM" (BType_Mem Bit64 Bit8))
              (BExp_Store (BExp_Den (BVar "MEM" (BType_Mem Bit64 Bit8)))
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                    (BExp_Den (BVar "R15" (BType_Imm Bit64))))
                 BEnd_LittleEndian
                 (BExp_Cast BIExp_LowCast
                    (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit8));
            BStmt_Observe (BExp_Const (Imm1 1w))
              [BExp_BinExp BIExp_RightShift
                 (BExp_BinExp BIExp_Plus
                    (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                    (BExp_Den (BVar "R15" (BType_Imm Bit64))))
                 (BExp_Const (Imm64 6w))] HD];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 28w)))|>;
       <|bb_label := BL_Address (Imm64 28w);
         bb_statements :=
           [BStmt_Assign (BVar "tmp_ProcState_C" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_Or
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1))))
                    (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1))))
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R18" (BType_Imm Bit64))) Bit32)
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R25" (BType_Imm Bit64))) Bit32)));
            BStmt_Assign (BVar "ProcState_N" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_Or
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1))))
                    (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1))))
                 (BExp_BinPred BIExp_SignedLessThan
                    (BExp_BinExp BIExp_Minus
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R25" (BType_Imm Bit64))) Bit32)
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R18" (BType_Imm Bit64))) Bit32))
                    (BExp_Const (Imm32 0w))));
            BStmt_Assign (BVar "ProcState_V" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_Or
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1))))
                    (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1))))
                 (BExp_BinPred BIExp_Equal
                    (BExp_BinPred BIExp_SignedLessThan
                       (BExp_BinExp BIExp_Minus
                          (BExp_Cast BIExp_LowCast
                             (BExp_Den (BVar "R25" (BType_Imm Bit64))) Bit32)
                          (BExp_Cast BIExp_LowCast
                             (BExp_Den (BVar "R18" (BType_Imm Bit64))) Bit32))
                       (BExp_Const (Imm32 0w)))
                    (BExp_BinPred BIExp_SignedLessOrEqual
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R18" (BType_Imm Bit64))) Bit32)
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R25" (BType_Imm Bit64))) Bit32))));
            BStmt_Assign (BVar "ProcState_Z" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_Or
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1))))
                    (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1))))
                 (BExp_BinPred BIExp_Equal
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R25" (BType_Imm Bit64))) Bit32)
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R18" (BType_Imm Bit64))) Bit32)));
            BStmt_Assign (BVar "ProcState_C" (BType_Imm Bit1))
              (BExp_Den (BVar "tmp_ProcState_C" (BType_Imm Bit1)))];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 32w)))|>;
       <|bb_label := BL_Address (Imm64 32w);
         bb_statements :=
           [BStmt_Assign (BVar "R8" (BType_Imm Bit64))
              (BExp_BinExp BIExp_Plus
                 (BExp_Den (BVar "R1" (BType_Imm Bit64)))
                 (BExp_BinExp BIExp_Mult
                    (BExp_Den (BVar "R15" (BType_Imm Bit64)))
                    (BExp_Den (BVar "R13" (BType_Imm Bit64)))))];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 36w)))|>;
       <|bb_label := BL_Address (Imm64 36w);
         bb_statements :=
           [BStmt_Assign (BVar "tmp_ProcState_C" (BType_Imm Bit1))
              (BExp_BinPred BIExp_LessOrEqual
                 (BExp_BinExp BIExp_And
                    (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1)))
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1)))))
                 (BExp_BinPred BIExp_LessOrEqual
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit32)
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R2" (BType_Imm Bit64))) Bit32)));
            BStmt_Assign (BVar "ProcState_N" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_And
                    (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1)))
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1)))))
                 (BExp_BinPred BIExp_SignedLessThan
                    (BExp_BinExp BIExp_Minus
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R2" (BType_Imm Bit64))) Bit32)
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit32))
                    (BExp_Const (Imm32 0w))));
            BStmt_Assign (BVar "ProcState_V" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_And
                    (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1)))
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1)))))
                 (BExp_BinPred BIExp_Equal
                    (BExp_BinPred BIExp_SignedLessThan
                       (BExp_BinExp BIExp_Minus
                          (BExp_Cast BIExp_LowCast
                             (BExp_Den (BVar "R2" (BType_Imm Bit64))) Bit32)
                          (BExp_Cast BIExp_LowCast
                             (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit32))
                       (BExp_Const (Imm32 0w)))
                    (BExp_BinPred BIExp_SignedLessOrEqual
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit32)
                       (BExp_Cast BIExp_LowCast
                          (BExp_Den (BVar "R2" (BType_Imm Bit64))) Bit32))));
            BStmt_Assign (BVar "ProcState_Z" (BType_Imm Bit1))
              (BExp_BinExp BIExp_And
                 (BExp_BinExp BIExp_And
                    (BExp_Den (BVar "ProcState_C" (BType_Imm Bit1)))
                    (BExp_UnaryExp BIExp_Not
                       (BExp_Den (BVar "ProcState_Z" (BType_Imm Bit1)))))
                 (BExp_BinPred BIExp_Equal
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R2" (BType_Imm Bit64))) Bit32)
                    (BExp_Cast BIExp_LowCast
                       (BExp_Den (BVar "R14" (BType_Imm Bit64))) Bit32)));
            BStmt_Assign (BVar "ProcState_C" (BType_Imm Bit1))
              (BExp_Den (BVar "tmp_ProcState_C" (BType_Imm Bit1)))];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 40w)))|>;
       <|bb_label := BL_Address (Imm64 40w); bb_statements := [];
         bb_last_statement := BStmt_Halt (BExp_Const (Imm32 0w))|>]
     
``);

val prog_ldld_w_obs_reduced = ("prog_ldld_w_obs", ``
BirProgram
      [<|bb_label := BL_Address (Imm64 0w);
         bb_statements :=
           [BStmt_Assign (BVar "ProcState_C" (BType_Imm Bit1))
              (BExp_BinPred BIExp_LessOrEqual (BExp_Const (Imm64 0xCA2000w))
                 (BExp_Den (BVar "R0" (BType_Imm Bit64))));
            BStmt_Assign (BVar "ProcState_N" (BType_Imm Bit1))
              (BExp_BinPred BIExp_SignedLessThan
                 (BExp_BinExp BIExp_Minus
                    (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                    (BExp_Const (Imm64 0xCA2000w))) (BExp_Const (Imm64 0w)));
            BStmt_Assign (BVar "ProcState_V" (BType_Imm Bit1))
              (BExp_BinPred BIExp_Equal
                 (BExp_BinPred BIExp_SignedLessThan
                    (BExp_BinExp BIExp_Minus
                       (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                       (BExp_Const (Imm64 0xCA2000w)))
                    (BExp_Const (Imm64 0w)))
                 (BExp_BinPred BIExp_SignedLessOrEqual
                    (BExp_Const (Imm64 0xCA2000w))
                    (BExp_Den (BVar "R0" (BType_Imm Bit64)))));
            BStmt_Assign (BVar "ProcState_Z" (BType_Imm Bit1))
              (BExp_BinPred BIExp_Equal
                 (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                 (BExp_Const (Imm64 0xCA2000w)));
            BStmt_Assign (BVar "R15" (BType_Imm Bit64))
              (BExp_BinExp BIExp_Minus
                 (BExp_Den (BVar "R0" (BType_Imm Bit64)))
                 (BExp_Const (Imm64 0xCA2000w)))];
         bb_last_statement := BStmt_Jmp (BLE_Label (BL_Address (Imm64 4w)))|>;
       <|bb_label := BL_Address (Imm64 4w); bb_statements := [];
         bb_last_statement :=
           BStmt_CJmp (BExp_Den (BVar "ProcState_V" (BType_Imm Bit1)))
             (BLE_Label (BL_Address (Imm64 40w)))
             (BLE_Label (BL_Address (Imm64 8w)))|>;
       <|bb_label := BL_Address (Imm64 40w); bb_statements := [];
         bb_last_statement := BStmt_Halt (BExp_Den (BVar "R18" (BType_Imm Bit64)))|>]
``);

val prog_ldld_w_obs = prog_ldld_w_obs_reduced;
val input_select_2  = true;

val (name, prog) = prog_ldld_w_obs;

val r0_1  = ``0x8000000000030000w:word64``
val r18_1 = ``0x1FFFFFFFFFFFFE00w:word64``

val r0_2  = ``0x8000000000000000w:word64``
val r18_2 = ``0xEFFFFFFFFFFFFE20w:word64``

val prog_par_r0_wtm  = if input_select_2 then r0_2  else r0_1;
val prog_par_r18_wtm = if input_select_2 then r18_2 else r18_1;

(* patch the end of the program: has to have a BIR halt instead of an arm8 ret *)
(* convention: last statement has to be the "exit" *)
val _ = print "patching in a \"halt\" statement...";
val prog_l = dest_BirProgram prog;

(* define a constant for the program *)
val prog_l_def = Define [QUOTE (name ^ "_prog_l = "), ANTIQUOTE prog_l];
val prog_const = (mk_BirProgram o fst o dest_eq o concl) prog_l_def;

(* obtain initial state for prog_l *)
val prog = (mk_BirProgram) prog_l;

val pc = (snd o dest_eq o concl o EVAL) ``bir_pc_first ^prog``;

val vars = gen_vars_of_prog prog;
val var_eq_thms = gen_var_eq_thms vars;

val env_init = bir_exec_env_initd_env vars;

(* r0 *)
val env_2 = (dest_some o snd o dest_eq o concl o (bir_exec_env_write_conv var_eq_thms))
            ``bir_env_write (BVar "R0" (BType_Imm Bit64)) (BVal_Imm (Imm64 ^(prog_par_r0_wtm))) ^env_init``;

(* 18 *)
val env_3 = (dest_some o snd o dest_eq o concl o (bir_exec_env_write_conv var_eq_thms))
            ``bir_env_write (BVar "R18" (BType_Imm Bit64)) (BVal_Imm (Imm64 ^(prog_par_r18_wtm))) ^env_2``;

val env = env_3;
val state = ``<| bst_pc := ^pc ; bst_environ := ^env ; bst_status := BST_Running |>``;


val validprog_o = NONE;
val welltypedprog_o = NONE;
val state_o = SOME state;

val _ = print "ok\n" (* loading complete *)



val n_max = 50;

val _ = print "ok\n";


val _ = bir_exec_prog_print name prog n_max validprog_o welltypedprog_o state_o;

