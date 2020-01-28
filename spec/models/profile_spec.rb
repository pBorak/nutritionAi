require "rails_helper"

RSpec.describe Profile, type: :model do
  context "with associations" do
    it { is_expected.to belong_to(:user) }
  end

  context "when validating model" do
    it { is_expected.to validate_inclusion_of(:sex).in_array(%w[male female]) }

    it do
      expect(described_class.new)
        .to validate_numericality_of(:protein_ratio)
        .is_greater_than_or_equal_to(2.0)
        .is_less_than_or_equal_to(2.6)
    end

    it do
      expect(described_class.new)
        .to validate_numericality_of(:fat_ratio)
        .is_greater_than_or_equal_to(0.2)
        .is_less_than_or_equal_to(0.4)
    end

    it do
      expect(described_class.new)
        .to validate_numericality_of(:activity_level)
        .is_greater_than_or_equal_to(1)
        .is_less_than_or_equal_to(5)
        .only_integer
    end

    it do
      expect(described_class.new)
        .to validate_numericality_of(:calorie_spread_ratio)
        .is_greater_than_or_equal_to(0.2)
        .is_less_than_or_equal_to(0.3)
    end
  end
end
