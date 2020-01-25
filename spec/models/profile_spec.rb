require "rails_helper"

RSpec.describe Profile, type: :model do
  context "with associations" do
    it { is_expected.to belong_to(:user) }
  end

  context "when validating model" do
    it { is_expected.to validate_presence_of(:sex) }
    it { is_expected.to validate_presence_of(:calorie_spread_ratio) }
    it { is_expected.to validate_presence_of(:fat_ratio) }
    it { is_expected.to validate_presence_of(:protein_ratio) }
    it { is_expected.to validate_presence_of(:activity_level) }

    it { is_expected.to validate_numericality_of(:protein_ratio) }
    it { is_expected.to validate_numericality_of(:fat_ratio) }
    it { is_expected.to validate_numericality_of(:activity_level) }
    it { is_expected.to validate_numericality_of(:calorie_spread_ratio) }
  end
end
