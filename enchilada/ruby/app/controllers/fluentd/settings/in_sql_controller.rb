class Fluentd::Settings::InSqlController < ApplicationController
  before_action :login_required
  before_action :find_fluentd

  include SettingEditConcern

  def show
    @setting = target_class.new(target_class.initial_params)
  end

  def finish
    @setting = target_class.new(setting_params)
    unless @setting.valid?
      return render "fluentd/settings/in_sql/show"
    end

    @fluentd.agent.config_append @setting.to_config
    if @fluentd.agent.running?
      unless @fluentd.agent.restart
        @setting.errors.add(:base, @fluentd.agent.log.tail(1).first)
        return render "fluentd/settings/in_sql/show"
      end
    end
    redirect_to source_daemon_setting_path(@fluentd)
  end

  private

  def setting_params
    params.require(target_class.to_s.underscore.gsub("/", "_")).permit(:host,
                                                                       :port,
                                                                       :database,
                                                                       :adapter,
                                                                       :username,
                                                                       :password,
                                                                       :tag_prefix,
                                                                       :select_interval,
                                                                       :select_limit,
                                                                       :state_file,
                                                                       :all_tables,
                                                                       table: [:table,
                                                                               :tag,
                                                                               :update_column,
                                                                               :time_column,
                                                                               :primary_key])
  end

  def target_class
    Fluentd::Setting::InSql
  end

  def plugin_setting_form_action_url(*args)
    send("finish_daemon_setting_#{target_plugin_name}_path", *args)
  end
end
