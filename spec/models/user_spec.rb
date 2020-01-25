require "rails_helper"

RSpec.describe User, type: :model do
  context "when validating model" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    context "when uniqeuness validation" do
      before { FactoryBot.create(:user) }

      it { is_expected.to validate_uniqueness_of(:email) }
    end

    it "validates email correctness" do
      user = described_class.new(
        email: "invalid",
        password: "password",
        first_name: "John",
        last_name: "Doe",
      )
      expected_error_message = "is invalid"

      expect(user.valid?).to be(false)
      expect(user.errors.messages[:email]).to include(expected_error_message)
    end

    it "validates password correctness" do
      user = described_class.new(
        email: "email@example.com",
        password: "pas",
        first_name: "John",
        last_name: "Doe",
      )
      expected_error_message = "is too short (minimum is 6 characters)"

      expect(user.valid?).to be(false)
      expect(user.errors.messages[:password]).to include(expected_error_message)
    end
  end

  context "with associations" do
    it { is_expected.to have_one(:profile).dependent(:destroy) }
  end
end
