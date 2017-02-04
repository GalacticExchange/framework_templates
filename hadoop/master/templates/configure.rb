


editor = get_editor '/etc/init.d/cassandra'

editor.search_file_replace_line(/^.*ulimit -l unlimited.*$/, '# ulimit -l unlimited')
editor.search_file_replace_line(/^.*ulimit -n.*$/, '# ulimit -n "$FD_LIMIT')

editor = get_editor '/etc/default/hive-webhcat-server'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export PYTHON_CMD=/usr/bin/python')

editor = get_editor '/etc/security/limits.conf'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'hdfs  -       nofile  32768')
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'hdfs  -       nproc   2048')


editor = get_editor '/etc/pam.d/common-session'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^# end of pam-auth-update config.*$/, 'session required  pam_limits.so')

editor = get_editor '/etc/hadoop/conf/hadoop-env.sh'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export HADOOP_PREFIX=/usr/lib/hadoop')
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec')
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export PATH=$HADOOP_PREFIX/bin:/usr/local/bin:/usr/lib/zookeeper:/usr/sbin:/usr/bin:/sbin:/bin:$PATH')


editor = get_editor '/etc/hadoop/conf/zookeeper-env.sh'
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export ZOOKEEPER_HOME=/usr/lib/zookeeper')
# noinspection RubyArgumentParentheses
editor.insert_line_after_match (/^#.*$/, 'export export PATH=\$ZOOKEEPER_HOME/bin:\$PATH')


# ENTERPRISSE RUN \
#        echo "hbase -       nofile  32768" >> /etc/security/limits.conf && \
#        echo "hbase -       nproc   2048" >> /etc/security/limits.conf && \
#        echo "session required  pam_limits.so" >> /etc/pam.d/common-session