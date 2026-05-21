class Article < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :tags

  has_ransackable_associations %w[account tags]
  ransack_can_autocomplete
end
