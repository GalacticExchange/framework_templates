# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170411133239) do

  create_table "agents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.integer  "status",     limit: 4
    t.integer  "source_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "host_summary", id: false, force: :cascade do |t|
    t.string  "host",                   limit: 60
    t.decimal "statements",                           precision: 64
    t.text    "statement_latency",      limit: 65535
    t.text    "statement_avg_latency",  limit: 65535
    t.decimal "table_scans",                          precision: 65
    t.decimal "file_ios",                             precision: 64
    t.text    "file_io_latency",        limit: 65535
    t.decimal "current_connections",                  precision: 41
    t.decimal "total_connections",                    precision: 41
    t.integer "unique_users",           limit: 8,                    default: 0, null: false
    t.text    "current_memory",         limit: 65535
    t.text    "total_memory_allocated", limit: 65535
  end

  create_table "host_summary_by_file_io", id: false, force: :cascade do |t|
    t.string  "host",       limit: 60
    t.decimal "ios",                      precision: 42
    t.text    "io_latency", limit: 65535
  end

  create_table "host_summary_by_file_io_type", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event_name",    limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "host_summary_by_stages", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event_name",    limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
  end

  create_table "host_summary_by_statement_latency", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.decimal "total",                       precision: 42
    t.text    "total_latency", limit: 65535
    t.text    "max_latency",   limit: 65535
    t.text    "lock_latency",  limit: 65535
    t.decimal "rows_sent",                   precision: 42
    t.decimal "rows_examined",               precision: 42
    t.decimal "rows_affected",               precision: 42
    t.decimal "full_scans",                  precision: 43
  end

  create_table "host_summary_by_statement_type", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "statement",     limit: 128
    t.integer "total",         limit: 8,                 null: false
    t.text    "total_latency", limit: 65535
    t.text    "max_latency",   limit: 65535
    t.text    "lock_latency",  limit: 65535
    t.integer "rows_sent",     limit: 8,                 null: false
    t.integer "rows_examined", limit: 8,                 null: false
    t.integer "rows_affected", limit: 8,                 null: false
    t.integer "full_scans",    limit: 8,     default: 0, null: false
  end

  create_table "in_forward_details", force: :cascade do |t|
    t.integer "source_id",             limit: 4
    t.string  "bind",                  limit: 255
    t.integer "port",                  limit: 4
    t.string  "linger_timeout",        limit: 255
    t.string  "chunk_size_limit",      limit: 255
    t.string  "chunk_size_warn_limit", limit: 255
    t.string  "log_level",             limit: 255
  end

  create_table "in_http_details", force: :cascade do |t|
    t.integer "source_id",         limit: 4
    t.string  "bind",              limit: 255
    t.integer "port",              limit: 4
    t.string  "body_size_limit",   limit: 255
    t.string  "keepalive_timeout", limit: 255
    t.string  "add_http_headers",  limit: 255
    t.string  "format",            limit: 255
    t.string  "log_level",         limit: 255
    t.string  "add_remote_addr",   limit: 255
  end

  create_table "in_sql_details", force: :cascade do |t|
    t.integer "source_id",       limit: 4
    t.string  "host",            limit: 255
    t.integer "port",            limit: 4
    t.string  "database",        limit: 255
    t.string  "adapter",         limit: 255
    t.string  "username",        limit: 255
    t.string  "password",        limit: 255
    t.string  "tag_prefix",      limit: 255
    t.string  "select_interval", limit: 255
    t.string  "select_limit",    limit: 255
    t.string  "state_file",      limit: 255
    t.string  "table",           limit: 255
  end

  create_table "in_tail_details", force: :cascade do |t|
    t.integer "source_id",        limit: 4
    t.string  "path",             limit: 255
    t.string  "tag",              limit: 255
    t.string  "format",           limit: 255
    t.string  "regexp",           limit: 255
    t.string  "time_format",      limit: 255
    t.string  "rotate_wait",      limit: 255
    t.string  "pos_file",         limit: 255
    t.string  "read_from_head",   limit: 255
    t.string  "refresh_interval", limit: 255
  end

  create_table "in_twitter_details", force: :cascade do |t|
    t.integer "source_id",           limit: 4
    t.string  "consumer_key",        limit: 255
    t.string  "consumer_secret",     limit: 255
    t.string  "access_token",        limit: 255
    t.string  "access_token_secret", limit: 255
    t.string  "tag",                 limit: 255
    t.string  "timeline",            limit: 255
    t.string  "keyword",             limit: 255
    t.string  "follow_ids",          limit: 255
    t.string  "locations",           limit: 255
    t.string  "lang",                limit: 255
    t.string  "output_format",       limit: 255
    t.string  "flatten_separator",   limit: 255
  end

  create_table "innodb_buffer_stats_by_schema", id: false, force: :cascade do |t|
    t.text    "object_schema", limit: 65535
    t.text    "allocated",     limit: 65535
    t.text    "data",          limit: 65535
    t.integer "pages",         limit: 8,                    default: 0, null: false
    t.integer "pages_hashed",  limit: 8,                    default: 0, null: false
    t.integer "pages_old",     limit: 8,                    default: 0, null: false
    t.decimal "rows_cached",                 precision: 44
  end

  create_table "innodb_buffer_stats_by_table", id: false, force: :cascade do |t|
    t.text    "object_schema", limit: 65535
    t.text    "object_name",   limit: 65535
    t.text    "allocated",     limit: 65535
    t.text    "data",          limit: 65535
    t.integer "pages",         limit: 8,                    default: 0, null: false
    t.integer "pages_hashed",  limit: 8,                    default: 0, null: false
    t.integer "pages_old",     limit: 8,                    default: 0, null: false
    t.decimal "rows_cached",                 precision: 44
  end

  create_table "innodb_lock_waits", id: false, force: :cascade do |t|
    t.datetime "wait_started"
    t.time     "wait_age"
    t.integer  "wait_age_secs",                limit: 8
    t.string   "locked_table",                 limit: 1024,       default: "", null: false
    t.string   "locked_index",                 limit: 1024
    t.string   "locked_type",                  limit: 32,         default: "", null: false
    t.string   "waiting_trx_id",               limit: 18,         default: "", null: false
    t.datetime "waiting_trx_started",                                          null: false
    t.time     "waiting_trx_age"
    t.integer  "waiting_trx_rows_locked",      limit: 8,          default: 0,  null: false
    t.integer  "waiting_trx_rows_modified",    limit: 8,          default: 0,  null: false
    t.integer  "waiting_pid",                  limit: 8,          default: 0,  null: false
    t.text     "waiting_query",                limit: 4294967295
    t.string   "waiting_lock_id",              limit: 81,         default: "", null: false
    t.string   "waiting_lock_mode",            limit: 32,         default: "", null: false
    t.string   "blocking_trx_id",              limit: 18,         default: "", null: false
    t.integer  "blocking_pid",                 limit: 8,          default: 0,  null: false
    t.text     "blocking_query",               limit: 4294967295
    t.string   "blocking_lock_id",             limit: 81,         default: "", null: false
    t.string   "blocking_lock_mode",           limit: 32,         default: "", null: false
    t.datetime "blocking_trx_started",                                         null: false
    t.time     "blocking_trx_age"
    t.integer  "blocking_trx_rows_locked",     limit: 8,          default: 0,  null: false
    t.integer  "blocking_trx_rows_modified",   limit: 8,          default: 0,  null: false
    t.string   "sql_kill_blocking_query",      limit: 32
    t.string   "sql_kill_blocking_connection", limit: 26
  end

  create_table "io_by_thread_by_latency", id: false, force: :cascade do |t|
    t.string  "user",           limit: 128
    t.decimal "total",                        precision: 42
    t.text    "total_latency",  limit: 65535
    t.text    "min_latency",    limit: 65535
    t.text    "avg_latency",    limit: 65535
    t.text    "max_latency",    limit: 65535
    t.integer "thread_id",      limit: 8,                    null: false
    t.integer "processlist_id", limit: 8
  end

  create_table "io_global_by_file_by_bytes", id: false, force: :cascade do |t|
    t.string  "file",          limit: 512
    t.integer "count_read",    limit: 8,                                            null: false
    t.text    "total_read",    limit: 65535
    t.text    "avg_read",      limit: 65535
    t.integer "count_write",   limit: 8,                                            null: false
    t.text    "total_written", limit: 65535
    t.text    "avg_write",     limit: 65535
    t.text    "total",         limit: 65535
    t.decimal "write_pct",                   precision: 26, scale: 2, default: 0.0, null: false
  end

  create_table "io_global_by_file_by_latency", id: false, force: :cascade do |t|
    t.string  "file",          limit: 512
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.integer "count_read",    limit: 8,     null: false
    t.text    "read_latency",  limit: 65535
    t.integer "count_write",   limit: 8,     null: false
    t.text    "write_latency", limit: 65535
    t.integer "count_misc",    limit: 8,     null: false
    t.text    "misc_latency",  limit: 65535
  end

  create_table "io_global_by_wait_by_bytes", id: false, force: :cascade do |t|
    t.string  "event_name",      limit: 128
    t.integer "total",           limit: 8,     null: false
    t.text    "total_latency",   limit: 65535
    t.text    "min_latency",     limit: 65535
    t.text    "avg_latency",     limit: 65535
    t.text    "max_latency",     limit: 65535
    t.integer "count_read",      limit: 8,     null: false
    t.text    "total_read",      limit: 65535
    t.text    "avg_read",        limit: 65535
    t.integer "count_write",     limit: 8,     null: false
    t.text    "total_written",   limit: 65535
    t.text    "avg_written",     limit: 65535
    t.text    "total_requested", limit: 65535
  end

  create_table "io_global_by_wait_by_latency", id: false, force: :cascade do |t|
    t.string  "event_name",    limit: 128
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
    t.text    "read_latency",  limit: 65535
    t.text    "write_latency", limit: 65535
    t.text    "misc_latency",  limit: 65535
    t.integer "count_read",    limit: 8,     null: false
    t.text    "total_read",    limit: 65535
    t.text    "avg_read",      limit: 65535
    t.integer "count_write",   limit: 8,     null: false
    t.text    "total_written", limit: 65535
    t.text    "avg_written",   limit: 65535
  end

  create_table "latest_file_io", id: false, force: :cascade do |t|
    t.string "thread",    limit: 149
    t.string "file",      limit: 512
    t.text   "latency",   limit: 65535
    t.string "operation", limit: 32,    null: false
    t.text   "requested", limit: 65535
  end

  create_table "memory_by_host_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "host",               limit: 60
    t.decimal "current_count_used",               precision: 41
    t.text    "current_allocated",  limit: 65535
    t.text    "current_avg_alloc",  limit: 65535
    t.text    "current_max_alloc",  limit: 65535
    t.text    "total_allocated",    limit: 65535
  end

  create_table "memory_by_thread_by_current_bytes", id: false, force: :cascade do |t|
    t.integer "thread_id",          limit: 8,                    null: false
    t.string  "user",               limit: 128
    t.decimal "current_count_used",               precision: 41
    t.text    "current_allocated",  limit: 65535
    t.text    "current_avg_alloc",  limit: 65535
    t.text    "current_max_alloc",  limit: 65535
    t.text    "total_allocated",    limit: 65535
  end

  create_table "memory_by_user_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "user",               limit: 32
    t.decimal "current_count_used",               precision: 41
    t.text    "current_allocated",  limit: 65535
    t.text    "current_avg_alloc",  limit: 65535
    t.text    "current_max_alloc",  limit: 65535
    t.text    "total_allocated",    limit: 65535
  end

  create_table "memory_global_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "event_name",        limit: 128,   null: false
    t.integer "current_count",     limit: 8,     null: false
    t.text    "current_alloc",     limit: 65535
    t.text    "current_avg_alloc", limit: 65535
    t.integer "high_count",        limit: 8,     null: false
    t.text    "high_alloc",        limit: 65535
    t.text    "high_avg_alloc",    limit: 65535
  end

  create_table "memory_global_total", id: false, force: :cascade do |t|
    t.text "total_allocated", limit: 65535
  end

  create_table "metrics", id: false, force: :cascade do |t|
    t.string "Variable_name",  limit: 193
    t.text   "Variable_value", limit: 65535
    t.string "Type",           limit: 210
    t.string "Enabled",        limit: 7,     default: "", null: false
  end

  create_table "out_elastic_details", force: :cascade do |t|
    t.integer "output_id",  limit: 4
    t.string  "host",       limit: 255
    t.integer "port",       limit: 4
    t.string  "index_name", limit: 255
    t.string  "type_name",  limit: 255
  end

  create_table "out_kafka_details", force: :cascade do |t|
    t.integer "output_id",         limit: 4
    t.string  "brokers",           limit: 255
    t.string  "buffer_type",       limit: 255
    t.string  "buffer_path",       limit: 255
    t.string  "flush_interval",    limit: 255
    t.string  "default_topic",     limit: 255
    t.string  "output_data_type",  limit: 255
    t.string  "compression_codec", limit: 255
    t.integer "max_send_retries",  limit: 4
    t.integer "required_acks",     limit: 4
  end

  create_table "out_kassandra_details", force: :cascade do |t|
    t.integer "output_id",     limit: 4
    t.string  "hosts",         limit: 255
    t.string  "keyspace",      limit: 255
    t.string  "column_family", limit: 255
    t.string  "ttl",           limit: 255
    t.string  "schema",        limit: 255
    t.string  "json_column",   limit: 255
    t.string  "pop_data_keys", limit: 255
  end

  create_table "out_webhdfs_details", force: :cascade do |t|
    t.integer "output_id",      limit: 4
    t.string  "host",           limit: 255
    t.integer "port",           limit: 4
    t.string  "path",           limit: 255
    t.string  "flush_interval", limit: 255
    t.string  "format",         limit: 255
  end

  create_table "outputs", force: :cascade do |t|
    t.string "type", limit: 255
  end

  create_table "processlist", id: false, force: :cascade do |t|
    t.integer "thd_id",                 limit: 8,                                                null: false
    t.integer "conn_id",                limit: 8
    t.string  "user",                   limit: 128
    t.string  "db",                     limit: 64
    t.string  "command",                limit: 16
    t.string  "state",                  limit: 64
    t.integer "time",                   limit: 8
    t.text    "current_statement",      limit: 4294967295
    t.text    "statement_latency",      limit: 65535
    t.decimal "progress",                                  precision: 26, scale: 2
    t.text    "lock_latency",           limit: 65535
    t.integer "rows_examined",          limit: 8
    t.integer "rows_sent",              limit: 8
    t.integer "rows_affected",          limit: 8
    t.integer "tmp_tables",             limit: 8
    t.integer "tmp_disk_tables",        limit: 8
    t.string  "full_scan",              limit: 3,                                   default: "", null: false
    t.text    "last_statement",         limit: 4294967295
    t.text    "last_statement_latency", limit: 65535
    t.text    "current_memory",         limit: 65535
    t.string  "last_wait",              limit: 128
    t.text    "last_wait_latency",      limit: 65535
    t.string  "source",                 limit: 64
    t.text    "trx_latency",            limit: 65535
    t.string  "trx_state",              limit: 11
    t.string  "trx_autocommit",         limit: 3
    t.string  "pid",                    limit: 1024
    t.string  "program_name",           limit: 1024
  end

  create_table "ps_check_lost_instrumentation", id: false, force: :cascade do |t|
    t.string "variable_name",  limit: 64,   null: false
    t.string "variable_value", limit: 1024
  end

  create_table "schema_auto_increment_columns", id: false, force: :cascade do |t|
    t.string  "table_schema",         limit: 64,                                  default: "", null: false
    t.string  "table_name",           limit: 64,                                  default: "", null: false
    t.string  "column_name",          limit: 64,                                  default: "", null: false
    t.string  "data_type",            limit: 64,                                  default: "", null: false
    t.text    "column_type",          limit: 4294967295,                                       null: false
    t.integer "is_signed",            limit: 4,                                   default: 0,  null: false
    t.integer "is_unsigned",          limit: 4,                                   default: 0,  null: false
    t.integer "max_value",            limit: 8
    t.integer "auto_increment",       limit: 8
    t.decimal "auto_increment_ratio",                    precision: 25, scale: 4
  end

  create_table "schema_index_statistics", id: false, force: :cascade do |t|
    t.string  "table_schema",   limit: 64
    t.string  "table_name",     limit: 64
    t.string  "index_name",     limit: 64
    t.integer "rows_selected",  limit: 8,     null: false
    t.text    "select_latency", limit: 65535
    t.integer "rows_inserted",  limit: 8,     null: false
    t.text    "insert_latency", limit: 65535
    t.integer "rows_updated",   limit: 8,     null: false
    t.text    "update_latency", limit: 65535
    t.integer "rows_deleted",   limit: 8,     null: false
    t.text    "delete_latency", limit: 65535
  end

  create_table "schema_object_overview", id: false, force: :cascade do |t|
    t.string  "db",          limit: 64, default: "", null: false
    t.string  "object_type", limit: 64
    t.integer "count",       limit: 8,  default: 0,  null: false
  end

  create_table "schema_redundant_indexes", id: false, force: :cascade do |t|
    t.string  "table_schema",               limit: 64,    default: "", null: false
    t.string  "table_name",                 limit: 64,    default: "", null: false
    t.string  "redundant_index_name",       limit: 64,    default: "", null: false
    t.text    "redundant_index_columns",    limit: 65535
    t.integer "redundant_index_non_unique", limit: 8
    t.string  "dominant_index_name",        limit: 64,    default: "", null: false
    t.text    "dominant_index_columns",     limit: 65535
    t.integer "dominant_index_non_unique",  limit: 8
    t.integer "subpart_exists",             limit: 4,     default: 0,  null: false
    t.string  "sql_drop_index",             limit: 223
  end

  create_table "schema_table_lock_waits", id: false, force: :cascade do |t|
    t.string  "object_schema",                limit: 64
    t.string  "object_name",                  limit: 64
    t.integer "waiting_thread_id",            limit: 8,          null: false
    t.integer "waiting_pid",                  limit: 8
    t.text    "waiting_account",              limit: 65535
    t.string  "waiting_lock_type",            limit: 32,         null: false
    t.string  "waiting_lock_duration",        limit: 32,         null: false
    t.text    "waiting_query",                limit: 4294967295
    t.integer "waiting_query_secs",           limit: 8
    t.integer "waiting_query_rows_affected",  limit: 8
    t.integer "waiting_query_rows_examined",  limit: 8
    t.integer "blocking_thread_id",           limit: 8,          null: false
    t.integer "blocking_pid",                 limit: 8
    t.text    "blocking_account",             limit: 65535
    t.string  "blocking_lock_type",           limit: 32,         null: false
    t.string  "blocking_lock_duration",       limit: 32,         null: false
    t.string  "sql_kill_blocking_query",      limit: 31
    t.string  "sql_kill_blocking_connection", limit: 25
  end

  create_table "schema_table_statistics", id: false, force: :cascade do |t|
    t.string  "table_schema",      limit: 64
    t.string  "table_name",        limit: 64
    t.text    "total_latency",     limit: 65535
    t.integer "rows_fetched",      limit: 8,                    null: false
    t.text    "fetch_latency",     limit: 65535
    t.integer "rows_inserted",     limit: 8,                    null: false
    t.text    "insert_latency",    limit: 65535
    t.integer "rows_updated",      limit: 8,                    null: false
    t.text    "update_latency",    limit: 65535
    t.integer "rows_deleted",      limit: 8,                    null: false
    t.text    "delete_latency",    limit: 65535
    t.decimal "io_read_requests",                precision: 42
    t.text    "io_read",           limit: 65535
    t.text    "io_read_latency",   limit: 65535
    t.decimal "io_write_requests",               precision: 42
    t.text    "io_write",          limit: 65535
    t.text    "io_write_latency",  limit: 65535
    t.decimal "io_misc_requests",                precision: 42
    t.text    "io_misc_latency",   limit: 65535
  end

  create_table "schema_table_statistics_with_buffer", id: false, force: :cascade do |t|
    t.string  "table_schema",               limit: 64
    t.string  "table_name",                 limit: 64
    t.integer "rows_fetched",               limit: 8,                                null: false
    t.text    "fetch_latency",              limit: 65535
    t.integer "rows_inserted",              limit: 8,                                null: false
    t.text    "insert_latency",             limit: 65535
    t.integer "rows_updated",               limit: 8,                                null: false
    t.text    "update_latency",             limit: 65535
    t.integer "rows_deleted",               limit: 8,                                null: false
    t.text    "delete_latency",             limit: 65535
    t.decimal "io_read_requests",                         precision: 42
    t.text    "io_read",                    limit: 65535
    t.text    "io_read_latency",            limit: 65535
    t.decimal "io_write_requests",                        precision: 42
    t.text    "io_write",                   limit: 65535
    t.text    "io_write_latency",           limit: 65535
    t.decimal "io_misc_requests",                         precision: 42
    t.text    "io_misc_latency",            limit: 65535
    t.text    "innodb_buffer_allocated",    limit: 65535
    t.text    "innodb_buffer_data",         limit: 65535
    t.text    "innodb_buffer_free",         limit: 65535
    t.integer "innodb_buffer_pages",        limit: 8,                    default: 0
    t.integer "innodb_buffer_pages_hashed", limit: 8,                    default: 0
    t.integer "innodb_buffer_pages_old",    limit: 8,                    default: 0
    t.decimal "innodb_buffer_rows_cached",                precision: 44, default: 0
  end

  create_table "schema_tables_with_full_table_scans", id: false, force: :cascade do |t|
    t.string  "object_schema",     limit: 64
    t.string  "object_name",       limit: 64
    t.integer "rows_full_scanned", limit: 8,     null: false
    t.text    "latency",           limit: 65535
  end

  create_table "schema_unused_indexes", id: false, force: :cascade do |t|
    t.string "object_schema", limit: 64
    t.string "object_name",   limit: 64
    t.string "index_name",    limit: 64
  end

  create_table "session", id: false, force: :cascade do |t|
    t.integer "thd_id",                 limit: 8,                                                null: false
    t.integer "conn_id",                limit: 8
    t.string  "user",                   limit: 128
    t.string  "db",                     limit: 64
    t.string  "command",                limit: 16
    t.string  "state",                  limit: 64
    t.integer "time",                   limit: 8
    t.text    "current_statement",      limit: 4294967295
    t.text    "statement_latency",      limit: 65535
    t.decimal "progress",                                  precision: 26, scale: 2
    t.text    "lock_latency",           limit: 65535
    t.integer "rows_examined",          limit: 8
    t.integer "rows_sent",              limit: 8
    t.integer "rows_affected",          limit: 8
    t.integer "tmp_tables",             limit: 8
    t.integer "tmp_disk_tables",        limit: 8
    t.string  "full_scan",              limit: 3,                                   default: "", null: false
    t.text    "last_statement",         limit: 4294967295
    t.text    "last_statement_latency", limit: 65535
    t.text    "current_memory",         limit: 65535
    t.string  "last_wait",              limit: 128
    t.text    "last_wait_latency",      limit: 65535
    t.string  "source",                 limit: 64
    t.text    "trx_latency",            limit: 65535
    t.string  "trx_state",              limit: 11
    t.string  "trx_autocommit",         limit: 3
    t.string  "pid",                    limit: 1024
    t.string  "program_name",           limit: 1024
  end

  create_table "session_ssl_status", id: false, force: :cascade do |t|
    t.integer "thread_id",           limit: 8,    null: false
    t.string  "ssl_version",         limit: 1024
    t.string  "ssl_cipher",          limit: 1024
    t.string  "ssl_sessions_reused", limit: 1024
  end

  create_table "sources", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statement_analysis", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.string   "full_scan",         limit: 1,                         default: "", null: false
    t.integer  "exec_count",        limit: 8,                                      null: false
    t.integer  "err_count",         limit: 8,                                      null: false
    t.integer  "warn_count",        limit: 8,                                      null: false
    t.text     "total_latency",     limit: 65535
    t.text     "max_latency",       limit: 65535
    t.text     "avg_latency",       limit: 65535
    t.text     "lock_latency",      limit: 65535
    t.integer  "rows_sent",         limit: 8,                                      null: false
    t.decimal  "rows_sent_avg",                        precision: 21, default: 0,  null: false
    t.integer  "rows_examined",     limit: 8,                                      null: false
    t.decimal  "rows_examined_avg",                    precision: 21, default: 0,  null: false
    t.integer  "rows_affected",     limit: 8,                                      null: false
    t.decimal  "rows_affected_avg",                    precision: 21, default: 0,  null: false
    t.integer  "tmp_tables",        limit: 8,                                      null: false
    t.integer  "tmp_disk_tables",   limit: 8,                                      null: false
    t.integer  "rows_sorted",       limit: 8,                                      null: false
    t.integer  "sort_merge_passes", limit: 8,                                      null: false
    t.string   "digest",            limit: 32
    t.datetime "first_seen",                                                       null: false
    t.datetime "last_seen",                                                        null: false
  end

  create_table "statements_with_errors_or_warnings", id: false, force: :cascade do |t|
    t.text     "query",       limit: 4294967295
    t.string   "db",          limit: 64
    t.integer  "exec_count",  limit: 8,                                                 null: false
    t.integer  "errors",      limit: 8,                                                 null: false
    t.decimal  "error_pct",                      precision: 27, scale: 4, default: 0.0, null: false
    t.integer  "warnings",    limit: 8,                                                 null: false
    t.decimal  "warning_pct",                    precision: 27, scale: 4, default: 0.0, null: false
    t.datetime "first_seen",                                                            null: false
    t.datetime "last_seen",                                                             null: false
    t.string   "digest",      limit: 32
  end

  create_table "statements_with_full_table_scans", id: false, force: :cascade do |t|
    t.text     "query",                    limit: 4294967295
    t.string   "db",                       limit: 64
    t.integer  "exec_count",               limit: 8,                                     null: false
    t.text     "total_latency",            limit: 65535
    t.integer  "no_index_used_count",      limit: 8,                                     null: false
    t.integer  "no_good_index_used_count", limit: 8,                                     null: false
    t.decimal  "no_index_used_pct",                           precision: 24, default: 0, null: false
    t.integer  "rows_sent",                limit: 8,                                     null: false
    t.integer  "rows_examined",            limit: 8,                                     null: false
    t.decimal  "rows_sent_avg",                               precision: 21
    t.decimal  "rows_examined_avg",                           precision: 21
    t.datetime "first_seen",                                                             null: false
    t.datetime "last_seen",                                                              null: false
    t.string   "digest",                   limit: 32
  end

  create_table "statements_with_runtimes_in_95th_percentile", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.string   "full_scan",         limit: 1,                         default: "", null: false
    t.integer  "exec_count",        limit: 8,                                      null: false
    t.integer  "err_count",         limit: 8,                                      null: false
    t.integer  "warn_count",        limit: 8,                                      null: false
    t.text     "total_latency",     limit: 65535
    t.text     "max_latency",       limit: 65535
    t.text     "avg_latency",       limit: 65535
    t.integer  "rows_sent",         limit: 8,                                      null: false
    t.decimal  "rows_sent_avg",                        precision: 21, default: 0,  null: false
    t.integer  "rows_examined",     limit: 8,                                      null: false
    t.decimal  "rows_examined_avg",                    precision: 21, default: 0,  null: false
    t.datetime "first_seen",                                                       null: false
    t.datetime "last_seen",                                                        null: false
    t.string   "digest",            limit: 32
  end

  create_table "statements_with_sorting", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.integer  "exec_count",        limit: 8,                                     null: false
    t.text     "total_latency",     limit: 65535
    t.integer  "sort_merge_passes", limit: 8,                                     null: false
    t.decimal  "avg_sort_merges",                      precision: 21, default: 0, null: false
    t.integer  "sorts_using_scans", limit: 8,                                     null: false
    t.integer  "sort_using_range",  limit: 8,                                     null: false
    t.integer  "rows_sorted",       limit: 8,                                     null: false
    t.decimal  "avg_rows_sorted",                      precision: 21, default: 0, null: false
    t.datetime "first_seen",                                                      null: false
    t.datetime "last_seen",                                                       null: false
    t.string   "digest",            limit: 32
  end

  create_table "statements_with_temp_tables", id: false, force: :cascade do |t|
    t.text     "query",                    limit: 4294967295
    t.string   "db",                       limit: 64
    t.integer  "exec_count",               limit: 8,                                     null: false
    t.text     "total_latency",            limit: 65535
    t.integer  "memory_tmp_tables",        limit: 8,                                     null: false
    t.integer  "disk_tmp_tables",          limit: 8,                                     null: false
    t.decimal  "avg_tmp_tables_per_query",                    precision: 21, default: 0, null: false
    t.decimal  "tmp_tables_to_disk_pct",                      precision: 24, default: 0, null: false
    t.datetime "first_seen",                                                             null: false
    t.datetime "last_seen",                                                              null: false
    t.string   "digest",                   limit: 32
  end

  create_table "sync", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.integer "agent_id", limit: 4
  end

  create_table "sys_config", primary_key: "variable", force: :cascade do |t|
    t.string   "value",    limit: 128
    t.datetime "set_time",             null: false
    t.string   "set_by",   limit: 128
  end

  create_table "test_table", force: :cascade do |t|
    t.string   "name",       limit: 45
    t.string   "surname",    limit: 45
    t.string   "age",        limit: 45
    t.integer  "salary",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_summary", id: false, force: :cascade do |t|
    t.string  "user",                   limit: 32
    t.decimal "statements",                           precision: 64
    t.text    "statement_latency",      limit: 65535
    t.text    "statement_avg_latency",  limit: 65535
    t.decimal "table_scans",                          precision: 65
    t.decimal "file_ios",                             precision: 64
    t.text    "file_io_latency",        limit: 65535
    t.decimal "current_connections",                  precision: 41
    t.decimal "total_connections",                    precision: 41
    t.integer "unique_hosts",           limit: 8,                    default: 0, null: false
    t.text    "current_memory",         limit: 65535
    t.text    "total_memory_allocated", limit: 65535
  end

  create_table "user_summary_by_file_io", id: false, force: :cascade do |t|
    t.string  "user",       limit: 32
    t.decimal "ios",                      precision: 42
    t.text    "io_latency", limit: 65535
  end

  create_table "user_summary_by_file_io_type", id: false, force: :cascade do |t|
    t.string  "user",        limit: 32
    t.string  "event_name",  limit: 128,   null: false
    t.integer "total",       limit: 8,     null: false
    t.text    "latency",     limit: 65535
    t.text    "max_latency", limit: 65535
  end

  create_table "user_summary_by_stages", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "event_name",    limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
  end

  create_table "user_summary_by_statement_latency", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.decimal "total",                       precision: 42
    t.text    "total_latency", limit: 65535
    t.text    "max_latency",   limit: 65535
    t.text    "lock_latency",  limit: 65535
    t.decimal "rows_sent",                   precision: 42
    t.decimal "rows_examined",               precision: 42
    t.decimal "rows_affected",               precision: 42
    t.decimal "full_scans",                  precision: 43
  end

  create_table "user_summary_by_statement_type", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "statement",     limit: 128
    t.integer "total",         limit: 8,                 null: false
    t.text    "total_latency", limit: 65535
    t.text    "max_latency",   limit: 65535
    t.text    "lock_latency",  limit: 65535
    t.integer "rows_sent",     limit: 8,                 null: false
    t.integer "rows_examined", limit: 8,                 null: false
    t.integer "rows_affected", limit: 8,                 null: false
    t.integer "full_scans",    limit: 8,     default: 0, null: false
  end

  create_table "version", id: false, force: :cascade do |t|
    t.string "sys_version",   limit: 5,  default: "", null: false
    t.string "mysql_version", limit: 23, default: "", null: false
  end

  create_table "wait_classes_global_by_avg_latency", id: false, force: :cascade do |t|
    t.string  "event_class",   limit: 128
    t.decimal "total",                       precision: 42
    t.text    "total_latency", limit: 65535
    t.text    "min_latency",   limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "wait_classes_global_by_latency", id: false, force: :cascade do |t|
    t.string  "event_class",   limit: 128
    t.decimal "total",                       precision: 42
    t.text    "total_latency", limit: 65535
    t.text    "min_latency",   limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "waits_by_host_by_latency", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event",         limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "waits_by_user_by_latency", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "event",         limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "waits_global_by_latency", id: false, force: :cascade do |t|
    t.string  "events",        limit: 128,   null: false
    t.integer "total",         limit: 8,     null: false
    t.text    "total_latency", limit: 65535
    t.text    "avg_latency",   limit: 65535
    t.text    "max_latency",   limit: 65535
  end

  create_table "x$host_summary", id: false, force: :cascade do |t|
    t.string  "host",                   limit: 60
    t.decimal "statements",                        precision: 64
    t.decimal "statement_latency",                 precision: 64
    t.decimal "statement_avg_latency",             precision: 65, scale: 4
    t.decimal "table_scans",                       precision: 65
    t.decimal "file_ios",                          precision: 64
    t.decimal "file_io_latency",                   precision: 64
    t.decimal "current_connections",               precision: 41
    t.decimal "total_connections",                 precision: 41
    t.integer "unique_users",           limit: 8,                           default: 0, null: false
    t.decimal "current_memory",                    precision: 63
    t.decimal "total_memory_allocated",            precision: 64
  end

  create_table "x$host_summary_by_file_io", id: false, force: :cascade do |t|
    t.string  "host",       limit: 60
    t.decimal "ios",                   precision: 42
    t.decimal "io_latency",            precision: 42
  end

  create_table "x$host_summary_by_file_io_type", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event_name",    limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "max_latency",   limit: 8,   null: false
  end

  create_table "x$host_summary_by_stages", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event_name",    limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "avg_latency",   limit: 8,   null: false
  end

  create_table "x$host_summary_by_statement_latency", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.decimal "total",                    precision: 42
    t.decimal "total_latency",            precision: 42
    t.integer "max_latency",   limit: 8
    t.decimal "lock_latency",             precision: 42
    t.decimal "rows_sent",                precision: 42
    t.decimal "rows_examined",            precision: 42
    t.decimal "rows_affected",            precision: 42
    t.decimal "full_scans",               precision: 43
  end

  create_table "x$host_summary_by_statement_type", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "statement",     limit: 128
    t.integer "total",         limit: 8,               null: false
    t.integer "total_latency", limit: 8,               null: false
    t.integer "max_latency",   limit: 8,               null: false
    t.integer "lock_latency",  limit: 8,               null: false
    t.integer "rows_sent",     limit: 8,               null: false
    t.integer "rows_examined", limit: 8,               null: false
    t.integer "rows_affected", limit: 8,               null: false
    t.integer "full_scans",    limit: 8,   default: 0, null: false
  end

  create_table "x$innodb_buffer_stats_by_schema", id: false, force: :cascade do |t|
    t.text    "object_schema", limit: 65535
    t.decimal "allocated",                   precision: 43
    t.decimal "data",                        precision: 43
    t.integer "pages",         limit: 8,                    default: 0, null: false
    t.integer "pages_hashed",  limit: 8,                    default: 0, null: false
    t.integer "pages_old",     limit: 8,                    default: 0, null: false
    t.decimal "rows_cached",                 precision: 44, default: 0, null: false
  end

  create_table "x$innodb_buffer_stats_by_table", id: false, force: :cascade do |t|
    t.text    "object_schema", limit: 65535
    t.text    "object_name",   limit: 65535
    t.decimal "allocated",                   precision: 43
    t.decimal "data",                        precision: 43
    t.integer "pages",         limit: 8,                    default: 0, null: false
    t.integer "pages_hashed",  limit: 8,                    default: 0, null: false
    t.integer "pages_old",     limit: 8,                    default: 0, null: false
    t.decimal "rows_cached",                 precision: 44, default: 0, null: false
  end

  create_table "x$innodb_lock_waits", id: false, force: :cascade do |t|
    t.datetime "wait_started"
    t.time     "wait_age"
    t.integer  "wait_age_secs",                limit: 8
    t.string   "locked_table",                 limit: 1024, default: "", null: false
    t.string   "locked_index",                 limit: 1024
    t.string   "locked_type",                  limit: 32,   default: "", null: false
    t.string   "waiting_trx_id",               limit: 18,   default: "", null: false
    t.datetime "waiting_trx_started",                                    null: false
    t.time     "waiting_trx_age"
    t.integer  "waiting_trx_rows_locked",      limit: 8,    default: 0,  null: false
    t.integer  "waiting_trx_rows_modified",    limit: 8,    default: 0,  null: false
    t.integer  "waiting_pid",                  limit: 8,    default: 0,  null: false
    t.string   "waiting_query",                limit: 1024
    t.string   "waiting_lock_id",              limit: 81,   default: "", null: false
    t.string   "waiting_lock_mode",            limit: 32,   default: "", null: false
    t.string   "blocking_trx_id",              limit: 18,   default: "", null: false
    t.integer  "blocking_pid",                 limit: 8,    default: 0,  null: false
    t.string   "blocking_query",               limit: 1024
    t.string   "blocking_lock_id",             limit: 81,   default: "", null: false
    t.string   "blocking_lock_mode",           limit: 32,   default: "", null: false
    t.datetime "blocking_trx_started",                                   null: false
    t.time     "blocking_trx_age"
    t.integer  "blocking_trx_rows_locked",     limit: 8,    default: 0,  null: false
    t.integer  "blocking_trx_rows_modified",   limit: 8,    default: 0,  null: false
    t.string   "sql_kill_blocking_query",      limit: 32
    t.string   "sql_kill_blocking_connection", limit: 26
  end

  create_table "x$io_by_thread_by_latency", id: false, force: :cascade do |t|
    t.string  "user",           limit: 128
    t.decimal "total",                      precision: 42
    t.decimal "total_latency",              precision: 42
    t.integer "min_latency",    limit: 8
    t.decimal "avg_latency",                precision: 24, scale: 4
    t.integer "max_latency",    limit: 8
    t.integer "thread_id",      limit: 8,                            null: false
    t.integer "processlist_id", limit: 8
  end

  create_table "x$io_global_by_file_by_bytes", id: false, force: :cascade do |t|
    t.string  "file",          limit: 512,                                        null: false
    t.integer "count_read",    limit: 8,                                          null: false
    t.integer "total_read",    limit: 8,                                          null: false
    t.decimal "avg_read",                  precision: 23, scale: 4, default: 0.0, null: false
    t.integer "count_write",   limit: 8,                                          null: false
    t.integer "total_written", limit: 8,                                          null: false
    t.decimal "avg_write",                 precision: 23, scale: 4, default: 0.0, null: false
    t.integer "total",         limit: 8,                            default: 0,   null: false
    t.decimal "write_pct",                 precision: 26, scale: 2, default: 0.0, null: false
  end

  create_table "x$io_global_by_file_by_latency", id: false, force: :cascade do |t|
    t.string  "file",          limit: 512, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "count_read",    limit: 8,   null: false
    t.integer "read_latency",  limit: 8,   null: false
    t.integer "count_write",   limit: 8,   null: false
    t.integer "write_latency", limit: 8,   null: false
    t.integer "count_misc",    limit: 8,   null: false
    t.integer "misc_latency",  limit: 8,   null: false
  end

  create_table "x$io_global_by_wait_by_bytes", id: false, force: :cascade do |t|
    t.string  "event_name",      limit: 128
    t.integer "total",           limit: 8,                                          null: false
    t.integer "total_latency",   limit: 8,                                          null: false
    t.integer "min_latency",     limit: 8,                                          null: false
    t.integer "avg_latency",     limit: 8,                                          null: false
    t.integer "max_latency",     limit: 8,                                          null: false
    t.integer "count_read",      limit: 8,                                          null: false
    t.integer "total_read",      limit: 8,                                          null: false
    t.decimal "avg_read",                    precision: 23, scale: 4, default: 0.0, null: false
    t.integer "count_write",     limit: 8,                                          null: false
    t.integer "total_written",   limit: 8,                                          null: false
    t.decimal "avg_written",                 precision: 23, scale: 4, default: 0.0, null: false
    t.integer "total_requested", limit: 8,                            default: 0,   null: false
  end

  create_table "x$io_global_by_wait_by_latency", id: false, force: :cascade do |t|
    t.string  "event_name",    limit: 128
    t.integer "total",         limit: 8,                                          null: false
    t.integer "total_latency", limit: 8,                                          null: false
    t.integer "avg_latency",   limit: 8,                                          null: false
    t.integer "max_latency",   limit: 8,                                          null: false
    t.integer "read_latency",  limit: 8,                                          null: false
    t.integer "write_latency", limit: 8,                                          null: false
    t.integer "misc_latency",  limit: 8,                                          null: false
    t.integer "count_read",    limit: 8,                                          null: false
    t.integer "total_read",    limit: 8,                                          null: false
    t.decimal "avg_read",                  precision: 23, scale: 4, default: 0.0, null: false
    t.integer "count_write",   limit: 8,                                          null: false
    t.integer "total_written", limit: 8,                                          null: false
    t.decimal "avg_written",               precision: 23, scale: 4, default: 0.0, null: false
  end

  create_table "x$latest_file_io", id: false, force: :cascade do |t|
    t.string  "thread",    limit: 149
    t.string  "file",      limit: 512
    t.integer "latency",   limit: 8
    t.string  "operation", limit: 32,  null: false
    t.integer "requested", limit: 8
  end

  create_table "x$memory_by_host_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "host",               limit: 60
    t.decimal "current_count_used",            precision: 41
    t.decimal "current_allocated",             precision: 41
    t.decimal "current_avg_alloc",             precision: 45, scale: 4, default: 0.0, null: false
    t.integer "current_max_alloc",  limit: 8
    t.decimal "total_allocated",               precision: 42
  end

  create_table "x$memory_by_thread_by_current_bytes", id: false, force: :cascade do |t|
    t.integer "thread_id",          limit: 8,                                          null: false
    t.string  "user",               limit: 128
    t.decimal "current_count_used",             precision: 41
    t.decimal "current_allocated",              precision: 41
    t.decimal "current_avg_alloc",              precision: 45, scale: 4, default: 0.0, null: false
    t.integer "current_max_alloc",  limit: 8
    t.decimal "total_allocated",                precision: 42
  end

  create_table "x$memory_by_user_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "user",               limit: 32
    t.decimal "current_count_used",            precision: 41
    t.decimal "current_allocated",             precision: 41
    t.decimal "current_avg_alloc",             precision: 45, scale: 4, default: 0.0, null: false
    t.integer "current_max_alloc",  limit: 8
    t.decimal "total_allocated",               precision: 42
  end

  create_table "x$memory_global_by_current_bytes", id: false, force: :cascade do |t|
    t.string  "event_name",        limit: 128,                                        null: false
    t.integer "current_count",     limit: 8,                                          null: false
    t.integer "current_alloc",     limit: 8,                                          null: false
    t.decimal "current_avg_alloc",             precision: 23, scale: 4, default: 0.0, null: false
    t.integer "high_count",        limit: 8,                                          null: false
    t.integer "high_alloc",        limit: 8,                                          null: false
    t.decimal "high_avg_alloc",                precision: 23, scale: 4, default: 0.0, null: false
  end

  create_table "x$memory_global_total", id: false, force: :cascade do |t|
    t.decimal "total_allocated", precision: 41
  end

  create_table "x$processlist", id: false, force: :cascade do |t|
    t.integer "thd_id",                 limit: 8,                                                null: false
    t.integer "conn_id",                limit: 8
    t.string  "user",                   limit: 128
    t.string  "db",                     limit: 64
    t.string  "command",                limit: 16
    t.string  "state",                  limit: 64
    t.integer "time",                   limit: 8
    t.text    "current_statement",      limit: 4294967295
    t.integer "statement_latency",      limit: 8
    t.decimal "progress",                                  precision: 26, scale: 2
    t.integer "lock_latency",           limit: 8
    t.integer "rows_examined",          limit: 8
    t.integer "rows_sent",              limit: 8
    t.integer "rows_affected",          limit: 8
    t.integer "tmp_tables",             limit: 8
    t.integer "tmp_disk_tables",        limit: 8
    t.string  "full_scan",              limit: 3,                                   default: "", null: false
    t.text    "last_statement",         limit: 4294967295
    t.integer "last_statement_latency", limit: 8
    t.decimal "current_memory",                            precision: 41
    t.string  "last_wait",              limit: 128
    t.string  "last_wait_latency",      limit: 20
    t.string  "source",                 limit: 64
    t.integer "trx_latency",            limit: 8
    t.string  "trx_state",              limit: 11
    t.string  "trx_autocommit",         limit: 3
    t.string  "pid",                    limit: 1024
    t.string  "program_name",           limit: 1024
  end

  create_table "x$ps_digest_95th_percentile_by_avg_us", id: false, force: :cascade do |t|
    t.decimal "avg_us",     precision: 21
    t.decimal "percentile", precision: 46, scale: 4, default: 0.0, null: false
  end

  create_table "x$ps_digest_avg_latency_distribution", id: false, force: :cascade do |t|
    t.integer "cnt",    limit: 8,                default: 0, null: false
    t.decimal "avg_us",           precision: 21
  end

  create_table "x$ps_schema_table_statistics_io", id: false, force: :cascade do |t|
    t.string  "table_schema",              limit: 64
    t.string  "table_name",                limit: 64
    t.decimal "count_read",                           precision: 42
    t.decimal "sum_number_of_bytes_read",             precision: 41
    t.decimal "sum_timer_read",                       precision: 42
    t.decimal "count_write",                          precision: 42
    t.decimal "sum_number_of_bytes_write",            precision: 41
    t.decimal "sum_timer_write",                      precision: 42
    t.decimal "count_misc",                           precision: 42
    t.decimal "sum_timer_misc",                       precision: 42
  end

  create_table "x$schema_flattened_keys", id: false, force: :cascade do |t|
    t.string  "table_schema",   limit: 64,    default: "", null: false
    t.string  "table_name",     limit: 64,    default: "", null: false
    t.string  "index_name",     limit: 64,    default: "", null: false
    t.integer "non_unique",     limit: 8
    t.integer "subpart_exists", limit: 8
    t.text    "index_columns",  limit: 65535
  end

  create_table "x$schema_index_statistics", id: false, force: :cascade do |t|
    t.string  "table_schema",   limit: 64
    t.string  "table_name",     limit: 64
    t.string  "index_name",     limit: 64
    t.integer "rows_selected",  limit: 8,  null: false
    t.integer "select_latency", limit: 8,  null: false
    t.integer "rows_inserted",  limit: 8,  null: false
    t.integer "insert_latency", limit: 8,  null: false
    t.integer "rows_updated",   limit: 8,  null: false
    t.integer "update_latency", limit: 8,  null: false
    t.integer "rows_deleted",   limit: 8,  null: false
    t.integer "delete_latency", limit: 8,  null: false
  end

  create_table "x$schema_table_lock_waits", id: false, force: :cascade do |t|
    t.string  "object_schema",                limit: 64
    t.string  "object_name",                  limit: 64
    t.integer "waiting_thread_id",            limit: 8,          null: false
    t.integer "waiting_pid",                  limit: 8
    t.text    "waiting_account",              limit: 65535
    t.string  "waiting_lock_type",            limit: 32,         null: false
    t.string  "waiting_lock_duration",        limit: 32,         null: false
    t.text    "waiting_query",                limit: 4294967295
    t.integer "waiting_query_secs",           limit: 8
    t.integer "waiting_query_rows_affected",  limit: 8
    t.integer "waiting_query_rows_examined",  limit: 8
    t.integer "blocking_thread_id",           limit: 8,          null: false
    t.integer "blocking_pid",                 limit: 8
    t.text    "blocking_account",             limit: 65535
    t.string  "blocking_lock_type",           limit: 32,         null: false
    t.string  "blocking_lock_duration",       limit: 32,         null: false
    t.string  "sql_kill_blocking_query",      limit: 31
    t.string  "sql_kill_blocking_connection", limit: 25
  end

  create_table "x$schema_table_statistics", id: false, force: :cascade do |t|
    t.string  "table_schema",      limit: 64
    t.string  "table_name",        limit: 64
    t.integer "total_latency",     limit: 8,                 null: false
    t.integer "rows_fetched",      limit: 8,                 null: false
    t.integer "fetch_latency",     limit: 8,                 null: false
    t.integer "rows_inserted",     limit: 8,                 null: false
    t.integer "insert_latency",    limit: 8,                 null: false
    t.integer "rows_updated",      limit: 8,                 null: false
    t.integer "update_latency",    limit: 8,                 null: false
    t.integer "rows_deleted",      limit: 8,                 null: false
    t.integer "delete_latency",    limit: 8,                 null: false
    t.decimal "io_read_requests",             precision: 42
    t.decimal "io_read",                      precision: 41
    t.decimal "io_read_latency",              precision: 42
    t.decimal "io_write_requests",            precision: 42
    t.decimal "io_write",                     precision: 41
    t.decimal "io_write_latency",             precision: 42
    t.decimal "io_misc_requests",             precision: 42
    t.decimal "io_misc_latency",              precision: 42
  end

  create_table "x$schema_table_statistics_with_buffer", id: false, force: :cascade do |t|
    t.string  "table_schema",               limit: 64
    t.string  "table_name",                 limit: 64
    t.integer "rows_fetched",               limit: 8,                             null: false
    t.integer "fetch_latency",              limit: 8,                             null: false
    t.integer "rows_inserted",              limit: 8,                             null: false
    t.integer "insert_latency",             limit: 8,                             null: false
    t.integer "rows_updated",               limit: 8,                             null: false
    t.integer "update_latency",             limit: 8,                             null: false
    t.integer "rows_deleted",               limit: 8,                             null: false
    t.integer "delete_latency",             limit: 8,                             null: false
    t.decimal "io_read_requests",                      precision: 42
    t.decimal "io_read",                               precision: 41
    t.decimal "io_read_latency",                       precision: 42
    t.decimal "io_write_requests",                     precision: 42
    t.decimal "io_write",                              precision: 41
    t.decimal "io_write_latency",                      precision: 42
    t.decimal "io_misc_requests",                      precision: 42
    t.decimal "io_misc_latency",                       precision: 42
    t.decimal "innodb_buffer_allocated",               precision: 43
    t.decimal "innodb_buffer_data",                    precision: 43
    t.decimal "innodb_buffer_free",                    precision: 44
    t.integer "innodb_buffer_pages",        limit: 8,                 default: 0
    t.integer "innodb_buffer_pages_hashed", limit: 8,                 default: 0
    t.integer "innodb_buffer_pages_old",    limit: 8,                 default: 0
    t.decimal "innodb_buffer_rows_cached",             precision: 44, default: 0
  end

  create_table "x$schema_tables_with_full_table_scans", id: false, force: :cascade do |t|
    t.string  "object_schema",     limit: 64
    t.string  "object_name",       limit: 64
    t.integer "rows_full_scanned", limit: 8,  null: false
    t.integer "latency",           limit: 8,  null: false
  end

  create_table "x$session", id: false, force: :cascade do |t|
    t.integer "thd_id",                 limit: 8,                                                null: false
    t.integer "conn_id",                limit: 8
    t.string  "user",                   limit: 128
    t.string  "db",                     limit: 64
    t.string  "command",                limit: 16
    t.string  "state",                  limit: 64
    t.integer "time",                   limit: 8
    t.text    "current_statement",      limit: 4294967295
    t.integer "statement_latency",      limit: 8
    t.decimal "progress",                                  precision: 26, scale: 2
    t.integer "lock_latency",           limit: 8
    t.integer "rows_examined",          limit: 8
    t.integer "rows_sent",              limit: 8
    t.integer "rows_affected",          limit: 8
    t.integer "tmp_tables",             limit: 8
    t.integer "tmp_disk_tables",        limit: 8
    t.string  "full_scan",              limit: 3,                                   default: "", null: false
    t.text    "last_statement",         limit: 4294967295
    t.integer "last_statement_latency", limit: 8
    t.decimal "current_memory",                            precision: 41
    t.string  "last_wait",              limit: 128
    t.string  "last_wait_latency",      limit: 20
    t.string  "source",                 limit: 64
    t.integer "trx_latency",            limit: 8
    t.string  "trx_state",              limit: 11
    t.string  "trx_autocommit",         limit: 3
    t.string  "pid",                    limit: 1024
    t.string  "program_name",           limit: 1024
  end

  create_table "x$statement_analysis", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.string   "full_scan",         limit: 1,                         default: "", null: false
    t.integer  "exec_count",        limit: 8,                                      null: false
    t.integer  "err_count",         limit: 8,                                      null: false
    t.integer  "warn_count",        limit: 8,                                      null: false
    t.integer  "total_latency",     limit: 8,                                      null: false
    t.integer  "max_latency",       limit: 8,                                      null: false
    t.integer  "avg_latency",       limit: 8,                                      null: false
    t.integer  "lock_latency",      limit: 8,                                      null: false
    t.integer  "rows_sent",         limit: 8,                                      null: false
    t.decimal  "rows_sent_avg",                        precision: 21, default: 0,  null: false
    t.integer  "rows_examined",     limit: 8,                                      null: false
    t.decimal  "rows_examined_avg",                    precision: 21, default: 0,  null: false
    t.integer  "rows_affected",     limit: 8,                                      null: false
    t.decimal  "rows_affected_avg",                    precision: 21, default: 0,  null: false
    t.integer  "tmp_tables",        limit: 8,                                      null: false
    t.integer  "tmp_disk_tables",   limit: 8,                                      null: false
    t.integer  "rows_sorted",       limit: 8,                                      null: false
    t.integer  "sort_merge_passes", limit: 8,                                      null: false
    t.string   "digest",            limit: 32
    t.datetime "first_seen",                                                       null: false
    t.datetime "last_seen",                                                        null: false
  end

  create_table "x$statements_with_errors_or_warnings", id: false, force: :cascade do |t|
    t.text     "query",       limit: 4294967295
    t.string   "db",          limit: 64
    t.integer  "exec_count",  limit: 8,                                                 null: false
    t.integer  "errors",      limit: 8,                                                 null: false
    t.decimal  "error_pct",                      precision: 27, scale: 4, default: 0.0, null: false
    t.integer  "warnings",    limit: 8,                                                 null: false
    t.decimal  "warning_pct",                    precision: 27, scale: 4, default: 0.0, null: false
    t.datetime "first_seen",                                                            null: false
    t.datetime "last_seen",                                                             null: false
    t.string   "digest",      limit: 32
  end

  create_table "x$statements_with_full_table_scans", id: false, force: :cascade do |t|
    t.text     "query",                    limit: 4294967295
    t.string   "db",                       limit: 64
    t.integer  "exec_count",               limit: 8,                                     null: false
    t.integer  "total_latency",            limit: 8,                                     null: false
    t.integer  "no_index_used_count",      limit: 8,                                     null: false
    t.integer  "no_good_index_used_count", limit: 8,                                     null: false
    t.decimal  "no_index_used_pct",                           precision: 24, default: 0, null: false
    t.integer  "rows_sent",                limit: 8,                                     null: false
    t.integer  "rows_examined",            limit: 8,                                     null: false
    t.decimal  "rows_sent_avg",                               precision: 21
    t.decimal  "rows_examined_avg",                           precision: 21
    t.datetime "first_seen",                                                             null: false
    t.datetime "last_seen",                                                              null: false
    t.string   "digest",                   limit: 32
  end

  create_table "x$statements_with_runtimes_in_95th_percentile", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.string   "full_scan",         limit: 1,                         default: "", null: false
    t.integer  "exec_count",        limit: 8,                                      null: false
    t.integer  "err_count",         limit: 8,                                      null: false
    t.integer  "warn_count",        limit: 8,                                      null: false
    t.integer  "total_latency",     limit: 8,                                      null: false
    t.integer  "max_latency",       limit: 8,                                      null: false
    t.integer  "avg_latency",       limit: 8,                                      null: false
    t.integer  "rows_sent",         limit: 8,                                      null: false
    t.decimal  "rows_sent_avg",                        precision: 21, default: 0,  null: false
    t.integer  "rows_examined",     limit: 8,                                      null: false
    t.decimal  "rows_examined_avg",                    precision: 21, default: 0,  null: false
    t.datetime "first_seen",                                                       null: false
    t.datetime "last_seen",                                                        null: false
    t.string   "digest",            limit: 32
  end

  create_table "x$statements_with_sorting", id: false, force: :cascade do |t|
    t.text     "query",             limit: 4294967295
    t.string   "db",                limit: 64
    t.integer  "exec_count",        limit: 8,                                     null: false
    t.integer  "total_latency",     limit: 8,                                     null: false
    t.integer  "sort_merge_passes", limit: 8,                                     null: false
    t.decimal  "avg_sort_merges",                      precision: 21, default: 0, null: false
    t.integer  "sorts_using_scans", limit: 8,                                     null: false
    t.integer  "sort_using_range",  limit: 8,                                     null: false
    t.integer  "rows_sorted",       limit: 8,                                     null: false
    t.decimal  "avg_rows_sorted",                      precision: 21, default: 0, null: false
    t.datetime "first_seen",                                                      null: false
    t.datetime "last_seen",                                                       null: false
    t.string   "digest",            limit: 32
  end

  create_table "x$statements_with_temp_tables", id: false, force: :cascade do |t|
    t.text     "query",                    limit: 4294967295
    t.string   "db",                       limit: 64
    t.integer  "exec_count",               limit: 8,                                     null: false
    t.integer  "total_latency",            limit: 8,                                     null: false
    t.integer  "memory_tmp_tables",        limit: 8,                                     null: false
    t.integer  "disk_tmp_tables",          limit: 8,                                     null: false
    t.decimal  "avg_tmp_tables_per_query",                    precision: 21, default: 0, null: false
    t.decimal  "tmp_tables_to_disk_pct",                      precision: 24, default: 0, null: false
    t.datetime "first_seen",                                                             null: false
    t.datetime "last_seen",                                                              null: false
    t.string   "digest",                   limit: 32
  end

  create_table "x$user_summary", id: false, force: :cascade do |t|
    t.string  "user",                   limit: 32
    t.decimal "statements",                        precision: 64
    t.decimal "statement_latency",                 precision: 64
    t.decimal "statement_avg_latency",             precision: 65, scale: 4, default: 0.0, null: false
    t.decimal "table_scans",                       precision: 65
    t.decimal "file_ios",                          precision: 64
    t.decimal "file_io_latency",                   precision: 64
    t.decimal "current_connections",               precision: 41
    t.decimal "total_connections",                 precision: 41
    t.integer "unique_hosts",           limit: 8,                           default: 0,   null: false
    t.decimal "current_memory",                    precision: 63
    t.decimal "total_memory_allocated",            precision: 64
  end

  create_table "x$user_summary_by_file_io", id: false, force: :cascade do |t|
    t.string  "user",       limit: 32
    t.decimal "ios",                   precision: 42
    t.decimal "io_latency",            precision: 42
  end

  create_table "x$user_summary_by_file_io_type", id: false, force: :cascade do |t|
    t.string  "user",        limit: 32
    t.string  "event_name",  limit: 128, null: false
    t.integer "total",       limit: 8,   null: false
    t.integer "latency",     limit: 8,   null: false
    t.integer "max_latency", limit: 8,   null: false
  end

  create_table "x$user_summary_by_stages", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "event_name",    limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "avg_latency",   limit: 8,   null: false
  end

  create_table "x$user_summary_by_statement_latency", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.decimal "total",                    precision: 42
    t.decimal "total_latency",            precision: 42
    t.decimal "max_latency",              precision: 42
    t.decimal "lock_latency",             precision: 42
    t.decimal "rows_sent",                precision: 42
    t.decimal "rows_examined",            precision: 42
    t.decimal "rows_affected",            precision: 42
    t.decimal "full_scans",               precision: 43
  end

  create_table "x$user_summary_by_statement_type", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "statement",     limit: 128
    t.integer "total",         limit: 8,               null: false
    t.integer "total_latency", limit: 8,               null: false
    t.integer "max_latency",   limit: 8,               null: false
    t.integer "lock_latency",  limit: 8,               null: false
    t.integer "rows_sent",     limit: 8,               null: false
    t.integer "rows_examined", limit: 8,               null: false
    t.integer "rows_affected", limit: 8,               null: false
    t.integer "full_scans",    limit: 8,   default: 0, null: false
  end

  create_table "x$wait_classes_global_by_avg_latency", id: false, force: :cascade do |t|
    t.string  "event_class",   limit: 128
    t.decimal "total",                     precision: 42
    t.decimal "total_latency",             precision: 42
    t.integer "min_latency",   limit: 8
    t.decimal "avg_latency",               precision: 46, scale: 4, default: 0.0, null: false
    t.integer "max_latency",   limit: 8
  end

  create_table "x$wait_classes_global_by_latency", id: false, force: :cascade do |t|
    t.string  "event_class",   limit: 128
    t.decimal "total",                     precision: 42
    t.decimal "total_latency",             precision: 42
    t.integer "min_latency",   limit: 8
    t.decimal "avg_latency",               precision: 46, scale: 4, default: 0.0, null: false
    t.integer "max_latency",   limit: 8
  end

  create_table "x$waits_by_host_by_latency", id: false, force: :cascade do |t|
    t.string  "host",          limit: 60
    t.string  "event",         limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "avg_latency",   limit: 8,   null: false
    t.integer "max_latency",   limit: 8,   null: false
  end

  create_table "x$waits_by_user_by_latency", id: false, force: :cascade do |t|
    t.string  "user",          limit: 32
    t.string  "event",         limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "avg_latency",   limit: 8,   null: false
    t.integer "max_latency",   limit: 8,   null: false
  end

  create_table "x$waits_global_by_latency", id: false, force: :cascade do |t|
    t.string  "events",        limit: 128, null: false
    t.integer "total",         limit: 8,   null: false
    t.integer "total_latency", limit: 8,   null: false
    t.integer "avg_latency",   limit: 8,   null: false
    t.integer "max_latency",   limit: 8,   null: false
  end

end
