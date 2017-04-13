class Output < ActiveRecord::Base
  def self.relate_to_details
    class_eval <<-EOF
      has_one :details, :class_name => "Fluentd::Setting::Detail::#{self.name.split('::').last}Detail"
      accepts_nested_attributes_for :details
      default_scope -> { includes(:details) }
    EOF
  end

  has_one :agent
end
