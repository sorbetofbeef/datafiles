# acat
# Autogenerated from man page /usr/share/man/man1/acat.1.gz
complete -c acat -s l -l list -d 'List files in archive'
complete -c acat -s x -l extract -d 'Extract files from archive'
complete -c acat -s X -l extract-to -d 'Extract files from archive to the specified directory'
complete -c acat -s a -l add -d 'Create archive.  This option is automatically assumed when apack is executed'
complete -c acat -s c -l cat -d 'Extract a file from archive to standard out (displaying it on screen)'
complete -c acat -s d -l diff -d 'Extract two archives and use diff(1) to generate differencies between them'
complete -c acat -s e -l each -d 'For each argument, execute the specified command'
complete -c acat -s F -l format -d 'Specify archive format manually (see ARCHIVE TYPES below)'
complete -c acat -s S -l simulate -d 'Run atool in simulation mode.  No changes to the filesystem (i. e'
complete -c acat -s E -l explain -d 'Display commands executed by atool'
complete -c acat -s p -l page -d 'Run output through a pager, usually pager unless the environment variable PAG…'
complete -c acat -s f -l force -d 'When extracting from files, allow overwriting of local files'
complete -c acat -s D -l subdir -d 'When extracting archives, always create a new directory for the archive even …'
complete -c acat -s 0 -l null -d 'If no file arguments are specified when creating or adding files to archives,…'
complete -c acat -s q -l quiet -d 'Decrease verbosity level by one'
complete -c acat -s v -l verbose -d 'Increase verbosity level by one'
complete -c acat -s V -l verbosity -d 'Specify verbosity level'
complete -c acat -l config -d 'Load configuration from the specified file'
complete -c acat -s o -l option -d 'Override a configuration option'
complete -c acat -s O -l format-option -d 'Send additional options to the archiver command'
complete -c acat -l save-outdir -d 'When extracting files, save the name of the directory which the archive was e…'
complete -c acat -l help -d 'Show summary of options'
complete -c acat -l version -d 'Output version information and exit'
