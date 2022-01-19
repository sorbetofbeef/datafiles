# orterun
# Autogenerated from man page /usr/share/man/man1/orterun.1.gz
complete -c orterun -s h -l help -d 'Display help for this command '
complete -c orterun -s q -l quiet -d 'Suppress informative messages from orterun during application execution'
complete -c orterun -s v -l verbose -d 'Be verbose '
complete -c orterun -s V -l version -d 'Print version number'
complete -c orterun -s N -d 'br Launch num processes per node on all allocated nodes (synonym for npernode)'
complete -c orterun -o display-map -l display-map -d 'Display a table showing the mapped location of each process prior to launch'
complete -c orterun -o display-allocation -l display-allocation -d 'Display the detected resource allocation'
complete -c orterun -o output-proctable -l output-proctable -d 'Output the debugger proctable after launch'
complete -c orterun -o dvm -l dvm -d 'Create a persistent distributed virtual machine (DVM)'
complete -c orterun -o max-vm-size -l max-vm-size -d 'Number of processes to run'
complete -c orterun -o novm -l novm -d 'Execute without creating an allocation-spanning virtual machine (only start d…'
complete -c orterun -o hnp -l hnp -d 'Specify the URI of the Head Node Process (HNP), or the name of the file (spec…'
complete -c orterun -s H -o host -l host -d 'List of hosts on which to invoke processes'
complete -c orterun -o hostfile -l hostfile -d 'Provide a hostfile to use'
complete -c orterun -o default-hostfile -l default-hostfile -d 'Provide a default hostfile'
complete -c orterun -o machinefile -l machinefile -d 'Synonym for -hostfile'
complete -c orterun -o cpu-set -l cpu-set -d 'Restrict launched processes to the specified logical cpus on each node (comma…'
complete -c orterun -s c -s n -l n -o np -d 'Run this many copies of the program on the given nodes'
complete -c orterun -o npersocket -l npersocket -d 'On each node, launch this many processes times the number of processor socket…'
complete -c orterun -o npernode -l npernode -d 'On each node, launch this many processes'
complete -c orterun -o pernode -l pernode -d 'On each node, launch one process -- equivalent to -npernode 1'
complete -c orterun -l map-by -d 'Map to the specified object, defaults to socket'
complete -c orterun -o bycore -l bycore -d 'Map processes by core (deprecated in favor of --map-by core) '
complete -c orterun -o byslot -l byslot -d 'Map and rank processes round-robin by slot'
complete -c orterun -o nolocal -l nolocal -d 'Do not run any copies of the launched application on the same node as orterun…'
complete -c orterun -o nooversubscribe -l nooversubscribe -d 'Do not oversubscribe any nodes; error (without starting any processes) if the…'
complete -c orterun -o oversubscribe -l oversubscribe -d 'Nodes are allowed to be oversubscribed, even on a managed system, and overloa…'
complete -c orterun -o bynode -l bynode -d 'Launch processes one per node, cycling by node in a round-robin fashion'
complete -c orterun -o cpu-list -l cpu-list -d 'Comma-delimited list of processor IDs to which to bind processes [default=NUL…'
complete -c orterun -l rank-by -d 'Rank in round-robin fashion according to the specified object, defaults to sl…'
complete -c orterun -l bind-to -d 'Bind processes to the specified object, defaults to core'
complete -c orterun -o cpus-per-proc -l cpus-per-proc -d 'Bind each process to the specified number of cpus'
complete -c orterun -o cpus-per-rank -l cpus-per-rank -d 'Alias for -cpus-per-proc.  (deprecated in favor of --map-by <obj>:PE=n) '
complete -c orterun -o bind-to-core -l bind-to-core -d 'Bind processes to cores (deprecated in favor of --bind-to core) '
complete -c orterun -o bind-to-socket -l bind-to-socket -d 'Bind processes to processor sockets  (deprecated in favor of --bind-to socket…'
complete -c orterun -o report-bindings -l report-bindings -d 'Report any bindings for launched processes. P For rankfiles: '
complete -c orterun -o rf -l rankfile -d 'Provide a rankfile file. P To manage standard I/O: '
complete -c orterun -o output-filename -l output-filename -d 'Redirect the stdout, stderr, and stddiag of all processes to a process-unique…'
complete -c orterun -o stdin -l stdin -d 'The MPI_COMM_WORLD rank of the process that is to receive stdin'
complete -c orterun -o merge-stderr-to-stdout -l merge-stderr-to-stdout -d 'Merge stderr to stdout for each process'
complete -c orterun -o tag-output -l tag-output -d 'Tag each line of output to stdout, stderr, and stddiag with [jobid, MCW_rank]…'
complete -c orterun -o timestamp-output -l timestamp-output -d 'Timestamp each line of output to stdout, stderr, and stddiag'
complete -c orterun -o xml -l xml -d 'Provide all output to stdout, stderr, and stddiag in an xml format'
complete -c orterun -o xml-file -l xml-file -d 'Provide all output in XML format to the specified file'
complete -c orterun -o xterm -l xterm -d 'Display the output from the processes identified by their MPI_COMM_WORLD rank…'
complete -c orterun -o path -l path -d '<path> that will be used when attempting to locate the requested executables'
complete -c orterun -l prefix -d 'Prefix directory that will be used to set the PATH and LD_LIBRARY_PATH on the…'
complete -c orterun -l noprefix -d 'Disable the automatic --prefix behavior '
complete -c orterun -s s -l preload-binary -d 'Copy the specified executable(s) to remote machines prior to starting remote …'
complete -c orterun -l preload-files -d 'Preload the comma separated list of files to the current working directory of…'
complete -c orterun -o set-cwd-to-session-dir -l set-cwd-to-session-dir -d 'Set the working directory of the started processes to their session directory'
complete -c orterun -o wd -d 'Synonym for -wdir'
complete -c orterun -o wdir -d 'Change to the directory <dir> before the user\'s program executes'
complete -c orterun -s x -d 'Export the specified environment variables to the remote nodes before executi…'
complete -c orterun -o gmca -l gmca -d 'Pass global MCA parameters that are applicable to all contexts'
complete -c orterun -o mca -l mca -d 'Send arguments to various MCA modules.   See the "MCA" section, below'
complete -c orterun -o am -d 'Aggregate MCA parameter set file list'
complete -c orterun -o tune -l tune -d 'Specify a tune file to set arguments for various MCA modules and environment …'
complete -c orterun -o debug -l debug -d 'Invoke the user-level debugger indicated by the orte_base_user_debugger MCA p…'
complete -c orterun -l get-stack-traces -d 'When paired with the  --timeout option,  mpirun will obtain and print out sta…'
complete -c orterun -o debugger -l debugger -d 'Sequence of debuggers to search for when --debug is used (i. e'
complete -c orterun -l timeout -d 'The maximum number of seconds that  mpirun (also known as  mpiexec, oshrun, o…'
complete -c orterun -o tv -l tv -d 'Launch processes under the TotalView debugger'
complete -c orterun -l allow-run-as-root -d 'Allow  mpirun to run when executed by the root user '
complete -c orterun -l app -d 'Provide an appfile, ignoring all other command line options'
complete -c orterun -o cf -l cartofile -d 'Provide a cartography file'
complete -c orterun -o continuous -l continuous -d 'Job is to run until explicitly terminated'
complete -c orterun -o disable-recovery -l disable-recovery -d 'Disable recovery (resets all recovery options to off)'
complete -c orterun -o do-not-launch -l do-not-launch -d 'Perform all necessary operations to prepare to launch the application, but do…'
complete -c orterun -o do-not-resolve -l do-not-resolve -d 'Do not attempt to resolve interfaces'
complete -c orterun -o enable-recovery -l enable-recovery -d 'Enable recovery from process failure [Default = disabled]'
complete -c orterun -o index-argv-by-rank -l index-argv-by-rank -d 'Uniquely index argv[0] for each process using its rank'
complete -c orterun -o leave-session-attached -l leave-session-attached -d 'Do not detach OmpiRTE daemons used by this application'
complete -c orterun -o max-restarts -l max-restarts -d 'Max number of times to restart a failed process'
complete -c orterun -o ompi-server -l ompi-server -d 'Specify the URI of the Open MPI server (or the mpirun to be used as the serve…'
complete -c orterun -o personality -l personality -d 'Comma-separated list of programming model, languages, and containers being us…'
complete -c orterun -l ppr -d 'Comma-separated list of number of processes on a given resource type [default…'
complete -c orterun -o report-child-jobs-separately -l report-child-jobs-separately -d 'Return the exit status of the primary job only'
complete -c orterun -o report-events -l report-events -d 'Report events to a tool listening at the specified URI'
complete -c orterun -o report-pid -l report-pid -d 'Print out mpirun\'s PID during startup'
complete -c orterun -o report-uri -l report-uri -d 'Print out mpirun\'s URI during startup'
complete -c orterun -o show-progress -l show-progress -d 'Output a brief periodic report on launch progress'
complete -c orterun -o terminate -l terminate -d 'Terminate the DVM'
complete -c orterun -o use-hwthread-cpus -l use-hwthread-cpus -d 'Use hardware threads as independent CPUs'
complete -c orterun -o use-regexp -l use-regexp -d 'Use regular expressions for launch'
complete -c orterun -s d -l debug-devel -d 'Enable debugging of the OmpiRTE (the run-time layer in Open MPI)'
complete -c orterun -l debug-daemons -d 'Enable debugging of any OmpiRTE daemons used by this application'
complete -c orterun -l debug-daemons-file -d 'Enable debugging of any OmpiRTE daemons used by this application, storing out…'
complete -c orterun -o display-devel-allocation -l display-devel-allocation -d 'Display a detailed list of the allocation being used by this job'
complete -c orterun -o display-devel-map -l display-devel-map -d 'Display a more detailed table showing the mapped location of each process pri…'
complete -c orterun -o display-diffable-map -l display-diffable-map -d 'Display a diffable process map just before launch'
complete -c orterun -o display-topo -l display-topo -d 'Display the topology as part of the process map just before launch'
complete -c orterun -o launch-agent -l launch-agent -d 'Name of the executable that is to be used to start processes on the remote no…'
complete -c orterun -l report-state-on-timeout -d 'When paired with the  --timeout command line option, report the run-time subs…'

