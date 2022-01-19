# atool
# Autogenerated from man page /usr/share/man/man1/atool.1.gz
complete -c atool -s l -l list -d 'List files in archive'
complete -c atool -s x -l extract -d 'Extract files from archive'
complete -c atool -s X -l extract-to -d 'Extract files from archive to the specified directory'
complete -c atool -s a -l add -d 'Create archive.  This option is automatically assumed when apack is executed'
complete -c atool -s c -l cat -d 'Extract a file from archive to standard out (displaying it on screen)'
complete -c atool -s d -l diff -d 'Extract two archives and use diff(1) to generate differencies between them'
complete -c atool -s e -l each -d 'For each argument, execute the specified command'
complete -c atool -s F -l format -d 'Specify archive format manually (see ARCHIVE TYPES below)'
complete -c atool -s S -l simulate -d 'Run atool in simulation mode.  No changes to the filesystem (i. e'
complete -c atool -s E -l explain -d 'Display commands executed by atool'
complete -c atool -s p -l page -d 'Run output through a pager, usually pager unless the environment variable PAG…'
complete -c atool -s f -l force -d 'When extracting from files, allow overwriting of local files'
complete -c atool -s D -l subdir -d 'When extracting archives, always create a new directory for the archive even …'
complete -c atool -s 0 -l null -d 'If no file arguments are specified when creating or adding files to archives,…'
complete -c atool -s q -l quiet -d 'Decrease verbosity level by one'
complete -c atool -s v -l verbose -d 'Increase verbosity level by one'
complete -c atool -s V -l verbosity -d 'Specify verbosity level'
complete -c atool -l config -d 'Load configuration from the specified file'
complete -c atool -s o -l option -d 'Override a configuration option'
complete -c atool -s O -l format-option -d 'Send additional options to the archiver command'
complete -c atool -l save-outdir -d 'When extracting files, save the name of the directory which the archive was e…'
complete -c atool -l help -d 'Show summary of options'
complete -c atool -l version -d 'Output version information and exit'

