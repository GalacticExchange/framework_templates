class Fluentd
  module Setting
    module Detail
      class InHttpDetail < ActiveRecord::Base
        belongs_to :source
      end
    end
  end
end
