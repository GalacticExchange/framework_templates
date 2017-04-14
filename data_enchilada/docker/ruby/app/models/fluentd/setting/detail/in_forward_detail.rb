class Fluentd
  module Setting
    module Detail
      class InForwardDetail < ActiveRecord::Base
        belongs_to :source
      end
    end
  end
end
