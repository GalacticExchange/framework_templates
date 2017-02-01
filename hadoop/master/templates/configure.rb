editor = get_editor '/etc/init.d/cassandra'

editor.search_file_replace_line(/^.*ulimit -l unlimited.*$/, '# ulimit -l unlimited')
editor.search_file_replace_line(/^.*ulimit -n.*$/, '# ulimit -n "$FD_LIMIT')


