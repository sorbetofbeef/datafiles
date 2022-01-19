# tblgen
# Autogenerated from man page /usr/share/man/man1/tblgen.1.gz
complete -c tblgen -o help -d 'Print a description of the command line options'
complete -c tblgen -o help-list -d 'Print a description of the command line options in a simple list format'
complete -c tblgen -s D -d 'Specify the name of a macro to be defined'
complete -c tblgen -s d -d 'Specify the name of the dependency filename'
complete -c tblgen -o debug -d 'Enable debug output'
complete -c tblgen -o dump-json -d 'Print a JSON representation of all records, suitable for further automated pr…'
complete -c tblgen -s I -d 'Specify where to find other target description files for inclusion'
complete -c tblgen -o null-backend -d 'Parse the source files and build the records, but do not run any backend'
complete -c tblgen -s o -d 'Specify the output file name'
complete -c tblgen -o print-records -d 'Print all classes and records to standard output (default backend option)'
complete -c tblgen -o print-detailed-records -d 'Print a detailed report of all global variables, classes, and records to stan…'
complete -c tblgen -o stats -d 'Print a report with any statistics collected by the backend'
complete -c tblgen -o time-phases -d 'Time the parser and backend phases and print a report'
complete -c tblgen -o version -d 'Show the version number of the program'
complete -c tblgen -o write-if-changed -d 'Write the output file only if it is new or has changed'
complete -c tblgen -o gen-clang-attr-classes -d 'Generate Clang attribute clases'
complete -c tblgen -o gen-clang-attr-parser-string-switches -d 'Generate all parser-related attribute string switches'
complete -c tblgen -o gen-clang-attr-subject-match-rules-parser-string-switches -d 'Generate all parser-related attribute subject match rule string switches'
complete -c tblgen -o gen-clang-attr-impl -d 'Generate Clang attribute implementations'
complete -c tblgen -o gen-clang-attr-list -d 'Generate a Clang attribute list'
complete -c tblgen -o gen-clang-attr-subject-match-rule-list -d 'Generate a Clang attribute subject match rule list'
complete -c tblgen -o gen-clang-attr-pch-read -d 'Generate Clang PCH attribute reader'
complete -c tblgen -o gen-clang-attr-pch-write -d 'Generate Clang PCH attribute writer'
complete -c tblgen -o gen-clang-attr-has-attribute-impl -d 'Generate a Clang attribute spelling list'
complete -c tblgen -o gen-clang-attr-spelling-index -d 'Generate a Clang attribute spelling index'
complete -c tblgen -o gen-clang-attr-ast-visitor -d 'Generate a recursive AST visitor for Clang attributes'
complete -c tblgen -o gen-clang-attr-template-instantiate -d 'Generate a Clang template instantiate code'
complete -c tblgen -o gen-clang-attr-parsed-attr-list -d 'Generate a Clang parsed attribute list'
complete -c tblgen -o gen-clang-attr-parsed-attr-impl -d 'Generate the Clang parsed attribute helpers'
complete -c tblgen -o gen-clang-attr-parsed-attr-kinds -d 'Generate a Clang parsed attribute kinds'
complete -c tblgen -o gen-clang-attr-text-node-dump -d 'Generate Clang attribute text node dumper'
complete -c tblgen -o gen-clang-attr-node-traverse -d 'Generate Clang attribute traverser'
complete -c tblgen -o gen-clang-diags-defs -d 'Generate Clang diagnostics definitions'
complete -c tblgen -o clang-component -d 'Only use warnings from specified component'
complete -c tblgen -o gen-clang-diag-groups -d 'Generate Clang diagnostic groups'
complete -c tblgen -o gen-clang-diags-index-name -d 'Generate Clang diagnostic name index'
complete -c tblgen -o gen-clang-basic-reader -d 'Generate Clang BasicReader classes'
complete -c tblgen -o gen-clang-basic-writer -d 'Generate Clang BasicWriter classes'
complete -c tblgen -o gen-clang-comment-nodes -d 'Generate Clang AST comment nodes'
complete -c tblgen -o gen-clang-decl-nodes -d 'Generate Clang AST declaration nodes'
complete -c tblgen -o gen-clang-stmt-nodes -d 'Generate Clang AST statement nodes'
complete -c tblgen -o gen-clang-type-nodes -d 'Generate Clang AST type nodes'
complete -c tblgen -o gen-clang-type-reader -d 'Generate Clang AbstractTypeReader class'
complete -c tblgen -o gen-clang-type-writer -d 'Generate Clang AbstractTypeWriter class'
complete -c tblgen -o gen-clang-opcodes -d 'Generate Clang constexpr interpreter opcodes'
complete -c tblgen -o gen-clang-sa-checkers -d 'Generate Clang static analyzer checkers'
complete -c tblgen -o gen-clang-comment-html-tags -d 'Generate efficient matchers for HTML tag names that are used in documentation…'
complete -c tblgen -o gen-clang-comment-html-tags-properties -d 'Generate efficient matchers for HTML tag properties'
complete -c tblgen -o gen-clang-comment-html-named-character-references -d 'Generate function to translate named character references to UTF-8 sequences'
complete -c tblgen -o gen-clang-comment-command-info -d 'Generate command properties for commands that are used in documentation comme…'
complete -c tblgen -o gen-clang-comment-command-list -d 'Generate list of commands that are used in documentation comments'
complete -c tblgen -o gen-clang-opencl-builtins -d 'Generate OpenCL builtin declaration handlers'
complete -c tblgen -o gen-arm-neon -d 'Generate arm_neon. h for Clang'
complete -c tblgen -o gen-arm-fp16 -d 'Generate arm_fp16. h for Clang'
complete -c tblgen -o gen-arm-bf16 -d 'Generate arm_bf16. h for Clang'
complete -c tblgen -o gen-arm-neon-sema -d 'Generate ARM NEON sema support for Clang'
complete -c tblgen -o gen-arm-neon-test -d 'Generate ARM NEON tests for Clang'
complete -c tblgen -o gen-arm-sve-header -d 'Generate arm_sve. h for Clang'
complete -c tblgen -o gen-arm-sve-builtins -d 'Generate arm_sve_builtins. inc for Clang'
complete -c tblgen -o gen-arm-sve-builtin-codegen -d 'Generate arm_sve_builtin_cg_map. inc for Clang'
complete -c tblgen -o gen-arm-sve-typeflags -d 'Generate arm_sve_typeflags. inc for Clang'
complete -c tblgen -o gen-arm-sve-sema-rangechecks -d 'Generate arm_sve_sema_rangechecks. inc for Clang'
complete -c tblgen -o gen-arm-mve-header -d 'Generate arm_mve. h for Clang'
complete -c tblgen -o gen-arm-mve-builtin-def -d 'Generate ARM MVE builtin definitions for Clang'
complete -c tblgen -o gen-arm-mve-builtin-sema -d 'Generate ARM MVE builtin sema checks for Clang'
complete -c tblgen -o gen-arm-mve-builtin-codegen -d 'Generate ARM MVE builtin code-generator for Clang'
complete -c tblgen -o gen-arm-mve-builtin-aliases -d 'Generate list of valid ARM MVE builtin aliases for Clang'
complete -c tblgen -o gen-arm-cde-header -d 'Generate arm_cde. h for Clang'
complete -c tblgen -o gen-arm-cde-builtin-def -d 'Generate ARM CDE builtin definitions for Clang'
complete -c tblgen -o gen-arm-cde-builtin-sema -d 'Generate ARM CDE builtin sema checks for Clang'
complete -c tblgen -o gen-arm-cde-builtin-codegen -d 'Generate ARM CDE builtin code-generator for Clang'
complete -c tblgen -o gen-arm-cde-builtin-aliases -d 'Generate list of valid ARM CDE builtin aliases for Clang'
complete -c tblgen -o gen-riscv-vector-header -d 'Generate riscv_vector. h for Clang'
complete -c tblgen -o gen-riscv-vector-builtins -d 'Generate riscv_vector_builtins. inc for Clang'
complete -c tblgen -o gen-riscv-vector-builtin-codegen -d 'Generate riscv_vector_builtin_cg. inc for Clang'
complete -c tblgen -o gen-attr-docs -d 'Generate attribute documentation'
complete -c tblgen -o gen-diag-docs -d 'Generate diagnostic documentation'
complete -c tblgen -o gen-opt-docs -d 'Generate option documentation'
complete -c tblgen -o gen-clang-data-collectors -d 'Generate data collectors for AST nodes'
complete -c tblgen -o gen-clang-test-pragma-attribute-supported-attributes -d 'Generate a list of attributes supported by #pragma Clang attribute for testin…'
complete -c tblgen -o gen-asm-matcher -d 'Generate assembly instruction matcher'
complete -c tblgen -o match-prefix -d 'Make -gen-asm-matcher match only instructions with the given prefix'
complete -c tblgen -o gen-asm-parser -d 'Generate assembly instruction parser'
complete -c tblgen -o asmparsernum -d 'Make -gen-asm-parser emit assembly parser number n'
complete -c tblgen -o gen-asm-writer -d 'Generate assembly writer'
complete -c tblgen -o asmwriternum -d 'Make -gen-asm-writer emit assembly writer number n'
complete -c tblgen -o gen-attrs -d 'Generate attributes'
complete -c tblgen -o gen-automata -d 'Generate generic automata'
complete -c tblgen -o gen-callingconv -d 'Generate calling convention descriptions'
complete -c tblgen -o gen-compress-inst-emitter -d 'Generate RISC-V compressed instructions'
complete -c tblgen -o gen-ctags -d 'Generate ctags-compatible index'
complete -c tblgen -o gen-dag-isel -d 'Generate a DAG (directed acyclic graph) instruction selector'
complete -c tblgen -o instrument-coverage -d 'Make -gen-dag-isel generate tables to help identify the patterns matched'
complete -c tblgen -o omit-comments -d 'Make -gen-dag-isel omit comments.  The default is false'
complete -c tblgen -o gen-dfa-packetizer -d 'Generate DFA Packetizer for VLIW targets'
complete -c tblgen -o gen-directive-decl -d 'Generate directive related declaration code (header file)'
complete -c tblgen -o gen-directive-gen -d 'Generate directive related implementation code part'
complete -c tblgen -o gen-directive-impl -d 'Generate directive related implementation code'
complete -c tblgen -o gen-disassembler -d 'Generate disassembler'
complete -c tblgen -o gen-emitter -d 'Generate machine code emitter'
complete -c tblgen -o gen-exegesis -d 'Generate llvm-exegesis tables'
complete -c tblgen -o gen-fast-isel -d 'Generate a "fast" instruction selector'
complete -c tblgen -o gen-global-isel -d 'Generate GlobalISel selector'
complete -c tblgen -o gisel-coverage-file -d 'Specify the file from which to retrieve coverage information'
complete -c tblgen -o instrument-gisel-coverage -d 'Make -gen-global-isel generate coverage instrumentation'
complete -c tblgen -o optimize-match-table -d 'Make -gen-global-isel generate an optimized version of the match table'
complete -c tblgen -o warn-on-skipped-patterns -d 'Make -gen-global-isel explain why a pattern was skipped for inclusion'
complete -c tblgen -o gen-global-isel-combiner -d 'Generate GlobalISel combiner'
complete -c tblgen -o combiners -d 'Make -gen-global-isel-combiner emit the specified combiners'
complete -c tblgen -o gicombiner-show-expansions -d 'Make -gen-global-isel-combiner use C++ comments to indicate occurrences of co…'
complete -c tblgen -o gicombiner-stop-after-build -d 'Make -gen-global-isel-combiner stop processing after building the match tree'
complete -c tblgen -o gicombiner-stop-after-parse -d 'Make -gen-global-isel-combiner stop processing after parsing rules and dump s…'
complete -c tblgen -o gen-instr-info -d 'Generate instruction descriptions'
complete -c tblgen -o gen-instr-docs -d 'Generate instruction documentation'
complete -c tblgen -o gen-intrinsic-enums -d 'Generate intrinsic enums'
complete -c tblgen -o intrinsic-prefix -d 'Make -gen-intrinsic-enums generate intrinsics with this target prefix'
complete -c tblgen -o gen-intrinsic-impl -d 'Generate intrinsic information'
complete -c tblgen -o gen-opt-parser-defs -d 'Generate options definitions'
complete -c tblgen -o gen-opt-rst -d 'Generate option RST'
complete -c tblgen -o gen-pseudo-lowering -d 'Generate pseudo instruction lowering'
complete -c tblgen -o gen-register-bank -d 'Generate register bank descriptions'
complete -c tblgen -o gen-register-info -d 'Generate registers and register classes info'
complete -c tblgen -o register-info-debug -d 'Make -gen-register-info dump register information for debugging'
complete -c tblgen -o gen-searchable-tables -d 'Generate generic searchable tables'
complete -c tblgen -o gen-subtarget -d 'Generate subtarget enumerations'
complete -c tblgen -o gen-x86-EVEX2VEX-tables -d 'Generate X86 EVEX to VEX compress tables'
complete -c tblgen -o gen-x86-fold-tables -d 'Generate X86 fold tables'
complete -c tblgen -o long-string-literals -d 'When emitting large string tables, prefer string literals over comma-separate…'
complete -c tblgen -o print-enums -d 'Print enumeration values for a class'
complete -c tblgen -o class -d 'Make -print-enums print the enumeration list for the specified class'
complete -c tblgen -o print-sets -d 'Print expanded sets for testing DAG exprs'
complete -c tblgen -o gen-avail-interface-decls -d 'Generate availability interface declarations'
complete -c tblgen -o gen-avail-interface-defs -d 'Generate op interface definitions'
complete -c tblgen -o gen-dialect-doc -d 'Generate dialect documentation'
complete -c tblgen -o dialect -d 'The dialect to generate'
complete -c tblgen -o gen-enum-decls -d 'Generate enum utility declarations'
complete -c tblgen -o gen-enum-defs -d 'Generate enum utility definitions'
complete -c tblgen -o gen-enum-from-llvmir-conversions -d 'Generate conversions of EnumAttrs from LLVM IR'
complete -c tblgen -o gen-enum-to-llvmir-conversions -d 'Generate conversions of EnumAttrs to LLVM IR'
complete -c tblgen -o gen-llvmir-conversions -d 'Generate LLVM IR conversions'
complete -c tblgen -o gen-llvmir-intrinsics -d 'Generate LLVM IR intrinsics'
complete -c tblgen -o llvmir-intrinsics-filter -d 'Only keep the intrinsics with the specified substring in their record name'
complete -c tblgen -o dialect-opclass-base -d 'The base class for the ops in the dialect we are to emit'
complete -c tblgen -o gen-op-decls -d 'Generate operation declarations'
complete -c tblgen -o gen-op-defs -d 'Generate operation definitions'
complete -c tblgen -o asmformat-error-is-fatal -d 'Emit a fatal error if format parsing fails'
complete -c tblgen -o op-exclude-regex -d 'Regular expression of name of ops to exclude (no filter if empty)'
complete -c tblgen -o op-include-regex -d 'Regular expression of name of ops to include (no filter if empty)'
complete -c tblgen -o gen-op-doc -d 'Generate operation documentation'
complete -c tblgen -o gen-pass-decls -d 'Generate operation documentation'
complete -c tblgen -o name -d 'The name of this group of passes'
complete -c tblgen -o gen-pass-doc -d 'Generate pass documentation'
complete -c tblgen -o gen-rewriters -d 'Generate pattern rewriters'
complete -c tblgen -o gen-spirv-avail-impls -d 'Generate SPIR-V operation utility definitions'
complete -c tblgen -o gen-spirv-capability-implication -d 'Generate utility function to return implied capabilities for a given capabili…'
complete -c tblgen -o gen-spirv-enum-avail-decls -d 'Generate SPIR-V enum availability declarations'
complete -c tblgen -o gen-spirv-enum-avail-defs -d 'Generate SPIR-V enum availability definitions'
complete -c tblgen -o gen-spirv-op-utils -d 'Generate SPIR-V operation utility definitions'
complete -c tblgen -o gen-spirv-serialization -d 'Generate SPIR-V (de)serialization utilities and functions'
complete -c tblgen -o gen-struct-attr-decls -d 'Generate struct utility declarations'
complete -c tblgen -o gen-struct-attr-defs -d 'Generate struct utility definitions'
complete -c tblgen -o gen-typedef-decls -d 'Generate TypeDef declarations'
complete -c tblgen -o gen-typedef-defs -d 'Generate TypeDef definitions'
complete -c tblgen -o typedefs-dialect -d 'Generate types for this dialect'

