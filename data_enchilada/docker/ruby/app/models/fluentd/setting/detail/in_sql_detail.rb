class Fluentd
  module Setting
    module Detail
      class InSqlDetail < ActiveRecord::Base
        belongs_to :source
      end
    end
  end
end
