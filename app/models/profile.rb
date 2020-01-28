class Profile < ApplicationRecord
  belongs_to :user

  validates :sex, inclusion: { in: %w[male female] }
  validates :calorie_spread_ratio, numericality: {
    greater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.3
  }
  validates :fat_ratio, numericality: {
    greater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.4
  }
  validates :protein_ratio, numericality: {
    greater_than_or_equal_to: 2.0, less_than_or_equal_to: 2.6
  }
  validates :activity_level, numericality: {
    greater_than_or_equal_to: 1.0, less_than_or_equal_to: 5.0,
    only_integer: true
  }
end
