class Output < ActiveRecord::Base
  def self.relate_to_details
    class_eval <<-EOF
      has_one :details, :class_name => "Fluentd::Setting::Detail::#{self.name.split('::').last}Detail", :foreign_key => :output_id
      accepts_nested_attributes_for :details
      default_scope -> { includes(:details) }
      after_initialize :details_setup

      def details_setup
        self.details = "Fluentd::Setting::Detail::#{self.name.split('::').last}Detail".constantize.new
      end
    EOF
  end

  has_one :agent
end
