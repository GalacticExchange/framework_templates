editor = get_editor '/etc/init.d/cassandra'

editor.file.search_file_replace_line(/^.*ulimit -l unlimited.*$/, '# ulimit -l unlimited')
editor.search_file_replace_line(/^.*ulimit -l unlimited.*$/, '# ulimit -n "$FD_LIMIT')


