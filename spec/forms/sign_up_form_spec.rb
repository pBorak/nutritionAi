require "rails_helper"

RSpec.describe SignUpForm do
  describe "#save" do
    context "with valid params" do
      it "creates user" do
        expect do
          described_class.new(
            email: "user@example.com",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          ).save
        end.to change(User, :count).by(1)
      end

      it "creates profile" do
        expect do
          described_class.new(
            email: "user@example.com",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          ).save
        end.to change(Profile, :count).by(1)
      end
    end

    context "with invalid params" do
      it "does not create user" do
        expect do
          described_class.new(
            email: "invalid",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          ).save
        end.not_to change(User, :count)
      end

      it "does not create profile" do
        expect do
          described_class.new(
            email: "invalid",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          ).save
        end.not_to change(Profile, :count)
      end
    end
  end
end
