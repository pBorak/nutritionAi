class Profile < ApplicationRecord
  belongs_to :user

  validates :sex, inclusion: { in: %w[male female] }, presence: true
  validates :calorie_spread_ratio, numericality: {
    greater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.3
  }, presence: true
  validates :fat_ratio, numericality: {
    greater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.4
  }, presence: true
  validates :protein_ratio, numericality: {
    greater_than_or_equal_to: 2.0, less_than_or_equal_to: 2.6
  }, presence: true
  validates :activity_level, numericality: {
    greater_than_or_equal_to: 1.0, less_than_or_equal_to: 5.0,
    only_integer: true
  }, presence: true
end
