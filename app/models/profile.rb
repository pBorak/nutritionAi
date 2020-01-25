class Profile < ApplicationRecord
  belongs_to :user

  validates :sex, inclusion: { in: %w[male female] }, presence: true
  validates :calorie_spread_ratio, numericality: {
    grater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.3
  }, presence: true
  validates :fat_ratio, numericality: {
    grater_than_or_equal_to: 0.2, less_than_or_equal_to: 0.4
  }, presence: true
  validates :protein_ratio, numericality: {
    grater_than_or_equal_to: 2.0, less_than_or_equal_to: 2.6
  }, presence: true
  validates :activity_level, numericality: {
    only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }, presence: true
end
