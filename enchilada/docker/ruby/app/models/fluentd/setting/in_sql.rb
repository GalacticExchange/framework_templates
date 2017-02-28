class Fluentd
  module Setting
    class InSql
      include ActiveModel::Model
      include Common

      KEYS = [
          :host,
          :port,
          :database,
          :adapter,
          :username,
          :password,
          :tag_prefix,
          :select_interval,
          :select_limit,
          :state_file,
          :table,
          :all_tables
      ].freeze

      attr_accessor(*KEYS)
      attr_accessor(:fields_descriptions)

      validates :host, presence: true
      validates :database, presence: true
      validates :adapter, presence: true
      validates :username, presence: true
      validates :password, presence: true
      validates :state_file, presence: true

      def self.initial_params
        {
            host: 'localhost',
            database: 'rdb_database',
            adapter: 'mysql2',
            username: 'myusername',
            password: 'mypassword',
            tag_prefix: 'my.rdb',
            select_interval: '60s',
            select_limit: '500',
            state_file: "/tmp/fluentd-#{Fluentd.instance.id}-#{Time.now.to_i}.pos",
            table: [
                {
                    table: 'rdb_table',
                    tag: 'rdb_table_tag',
                    update_column: 'updated_at',
                    time_column: 'updated_at',
                    primary_key: ''
                }
            ]
        }
      end

      def fields_descriptions
        {
            host: '* RDBMS host (required)',
            port: 'RDBMS port (optional)',
            database: '* RDBMS database name (required)',
            adapter: '* RDBMS driver name. You should install corresponding gem before start (mysql2 gem for mysql2 adapter, pg gem for postgresql adapter, etc. (required)',
            username: '* RDBMS login user name (required)',
            password: '* RDBMS login password (required)',
            tag_prefix: 'prefix of tags of events. actual tag will be this_tag_prefix.tables_tag (optional, but recommended)',
            select_interval: 'interval to run SQLs (optional)',
            select_limit: 'LIMIT of number of rows for each SQL (optional)',
            state_file: '* path to a file to store last rows (required)',
            all_tables: 'reads all tables instead of configuring each tables in &lt;table&gt; sections (optional)',
            table: {
                tag: 'tag name of events (optional; default value is table name)',
                table: '* RDBM table name',
                update_column: '* see above description',
                time_column: "(optional): if this option is set, this plugin uses this column's value as the the event's time. Otherwise it uses current time.",
                primary_key: "(optional): if you want to get data from the table which doesn't have primary key like PostgreSQL's View, set this parameter."
            }
        }
      end

      def common_options
        [
            :host,
            :port,
            :database,
            :adapter,
            :username,
            :password,
            :tag_prefix
        ]
      end

      def advanced_options
        [
            :select_interval,
            :select_limit,
            :state_file
        ]
      end

      def table=(value)
        @tables = value.map do |t|
          t.map{|field, value| ([field.to_sym, value] if table_fields.include?(field.to_sym))}.to_h
        end
      end

      def table
        @tables
      end

      def table_fields
        [
            :table,
            :tag,
            :update_column,
            :time_column,
            :primary_key
        ]
      end

      def to_config
        indent = "  "
        config = "<source>\n"
        config << "#{indent}type #{plugin_type_name}\n"
        self.class.const_get(:KEYS).each do |key|
          next if key == :table
          next if key == :all_tables
          config << indent
          config << conf(key)
          config << "\n"
        end
        tables = send(:table).reject{|t| t.values.join('') == ''} rescue []
        if tables.present? && conf(:all_tables) != '1'
          tables.each do |tab|
            config << "\n"
            config << indent
            config << "<table>\n"
            tab.each do |key, value|
              config << indent
              config << indent
              config << "#{key} #{value}"
              config << "\n"
            end
            config << indent
            config << "</table>\n"
          end
        else
          config << indent
          config << 'all_tables'
          config << "\n"
        end


        config << "</source>\n"
        config.gsub(/^[ ]*\n/m, "")
      end

      def self.create_from_config config
        @setting = {}
        @tables = []
        table = {}
        to_table = false
        str_params = config.split("\r\n").map{|str| str.squish}
        str_params.each do |str|
          case str
            when '<source>', '</source>'
              next
            when '<table>'
              to_table = true
            when '</table>'
              to_table = false
              @tables << table
              table = {}
            when 'all_tables'
              @setting[:all_tables] = true
            else
              param = str.split(' ')
              if to_table
                table[param.first] = param.second
              else
                @setting[param.first] = param.second unless param.first == 'type'
              end
          end
          if @tables.present?
            @setting[:table] = @tables
          end
        end
        self.new @setting
      end

      def plugin_name
        "sql"
      end
    end
  end
end
