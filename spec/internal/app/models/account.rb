class Account < ActiveRecord::Base
  has_many :articles
  ransack_can_autocomplete

  def self.ransackable_attributes(_auth_object = nil)
    column_names + _ransackers.keys.map(&:to_s)
  end
end
