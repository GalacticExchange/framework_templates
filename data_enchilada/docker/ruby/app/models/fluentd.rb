class Fluentd
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  validates :variant, inclusion: { in: proc { Fluentd.variants } }
  validates :log_file, presence: true
  validates :pid_file, presence: true
  validates :config_file, presence: true
  validate :validate_permissions

  before_validation :expand_paths

  COLUMNS = [:id, :variant, :log_file, :pid_file, :config_file]
  SERVER_PREFIX = "ip#{Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address).delete('.')}"
  # contents = IO.read("/etc/data_enchilada/data_enchilada.properties").strip

  # KAFKA_SERVER = contents.lines.first.split("=")[1].strip
  KAFKA_SERVER = '10.1.0.57'
  DEFAULT_CONF = <<-CONF.strip_heredoc
    <match fluent.*>
      @type stdout
    </match>

    <match #{SERVER_PREFIX}.**>
      @type kafka_buffered
      zookeeper #{KAFKA_SERVER}:2181
      schema_registry http://#{KAFKA_SERVER}:8081
      output_data_type avro
    </match>

    <match **.*>
      type retag
      add_prefix #{SERVER_PREFIX}
    </match>
  CONF

  attr_accessor(*COLUMNS)

  def self.variants
    %w(fluentd_gem td-agent)
  end

  def self.json_path
    FluentdUI.data_dir + "/#{Rails.env}-fluentd.json"
  end

  def fluentd?
    variant == "fluentd_gem"
  end
  alias :fluentd_gem? :fluentd?

  def td_agent?
    variant == "td-agent"
  end

  def agent
    klass = variant.underscore.camelize
    Agent.const_get(klass).new({
      :pid_file => pid_file,
      :log_file => log_file,
      :config_file => config_file,
    })
  end

  def load_settings_from_agent_default
    agent.class.default_options.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  def label
    "fluentd" # NOTE: for multiple fluentd management, but only single fluentd manage now
  end

  def expand_paths
    %w(pid_file log_file config_file).each do |column|
      path = send(column)
      next if path.blank?
      self.send("#{column}=", File.expand_path(path))
    end
  end

  def validate_permissions
    %w(pid_file log_file config_file).each do |column|
      check_permission(column)
    end
  end

  def check_permission(column)
    path = send(column)
    return if path.blank? # if empty, presence: true will catch it

    begin
      FileUtils.mkdir_p(File.dirname(path))
    rescue Errno::EACCES
      errors.add(column, :lack_write_permission)
      return
    end

    if File.exist?(path)
      if File.directory?(path)
        errors.add(column, :is_a_directory)
      end

      unless File.writable?(path)
        errors.add(column, :lack_write_permission)
      end
      unless File.readable?(path)
        errors.add(column, :lack_read_permission)
      end
    else
      unless File.writable?(File.dirname(path))
        errors.add(column, :lack_write_permission)
      end
    end
  end

  def ensure_default_config_file
    return true if File.size?(config_file)

    File.open(config_file, "w") do |f|
      f.write DEFAULT_CONF
    end
  end


  # ActiveRecord mimic

  def self.instance
    return unless exists?
    attr = JSON.parse(File.read(json_path))
    Fluentd.new(attr)
  end

  def self.exists?
    File.exists?(json_path)
  end

  def update_attributes(params)
    params.each_pair do |k, v|
      send("#{k}=", v)
    end
  end

  def save
    return false unless valid?
    json = COLUMNS.inject({}) do |result, col|
      result[col] = send(col)
      result
    end.to_json
    File.open(self.class.json_path, "w") do |f|
      f.write json
    end && ensure_default_config_file
  end

  def destroy
    File.unlink(self.class.json_path)
  end
end
