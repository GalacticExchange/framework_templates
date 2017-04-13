class Fluentd
  module Setting
    module Detail
      class InTwitterDetail < ActiveRecord::Base
        belongs_to :source
      end
    end
  end
end
