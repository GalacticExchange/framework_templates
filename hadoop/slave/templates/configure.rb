
editor = get_editor '/etc/init.d/cassandra'

editor.search_file_replace_line(/^.*ulimit -l unlimited.*$/, '# ulimit -l unlimited')
editor.search_file_replace_line(/^.*ulimit -n.*$/, '# ulimit -n "$FD_LIMIT')

editor = get_editor '/etc/security/limits.conf'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match(/^#.*$/, 'hdfs  -       nofile  32768')
# noinspection RubyArgumentParentheses
editor.insert_line_after_match(/^#.*$/, 'hdfs  -       nproc   2048')

editor = get_editor '/etc/pam.d/common-session'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match(/^# end of pam-auth-update config.*$/, 'session required  pam_limits.so')

e
# ENTERPRISSE RUN \
#        echo "hbase -       nofile  32768" >> /etc/security/limits.conf && \
#        echo "hbase -       nproc   2048" >> /etc/security/limits.conf && \
#        echo "session required  p
