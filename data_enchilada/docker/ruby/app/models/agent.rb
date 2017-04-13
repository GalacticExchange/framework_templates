class Agent < ActiveRecord::Base
  has_one :source
  has_many :outputs
  has_many :syncs
end
