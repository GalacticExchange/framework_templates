class Fluentd
  module Setting
    module Detail
      class InTailDetail < ActiveRecord::Base
        belongs_to :source
      end
    end
  end
end
