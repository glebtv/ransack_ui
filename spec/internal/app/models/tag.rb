class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles

  def self.ransackable_attributes(_auth_object = nil)
    column_names + _ransackers.keys.map(&:to_s)
  end
end
