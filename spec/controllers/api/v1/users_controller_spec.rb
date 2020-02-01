require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    context "with valid params" do
      it "creates user and profile" do
        params = {
          user: {
            email: "user@example.com",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
          },
          profile: {
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          },
        }

        post :create, params: params, as: :json

        expected_response = {
          id: User.last.id,
          email: "user@example.com",
          first_name: "John",
          last_name: "Doe",
          profile: {
            id: Profile.last.id,
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          },
        }

        expect(response.code).to eql("200")
        expect(User.count).to be(1)
        expect(Profile.count).to be(1)
        expect(response.body).to be_json_eql(expected_response.to_json)
      end
    end

    context "with invalid user params" do
      it "respond with validation errors and 422 status" do
        params = {
          user: {
            email: "invalid",
            first_name: "John",
            last_name: "Doe",
            password: "pass",
            password_confirmation: "pass",
          },
          profile: {
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 1,
          },
        }

        post :create, params: params, as: :json

        email_error = build_validation_errors("email", "invalid")
        password_error = build_validation_errors("password", "too_short")
        expect(response.body).to include_json(email_error)
          .at_path("errors")
        expect(response.body).to include_json(password_error)
          .at_path("errors")
        expect(response.code).to eql("422")
      end
    end

    context "with invalid profile params" do
      it "respond with validation errors and 422 status" do
        params = {
          user: {
            email: "test@example.com",
            first_name: "John",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
          },
          profile: {
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 10,
            activity_level: 1,
          },
        }

        post :create, params: params, as: :json

        protien_ratio_error = build_validation_errors(
          "protein_ratio", "too_small"
        )
        expect(response.code).to eql("422")
        expect(response.body).to include_json(protien_ratio_error)
          .at_path("errors")
      end
    end

    context "with both invalid profile  and user params" do
      it "respond with validation errors and 422 status" do
        params = {
          user: {
            email: "test@example.com",
            last_name: "Doe",
            password: "password",
            password_confirmation: "password",
          },
          profile: {
            sex: "male",
            calorie_spread_ratio: 0.2,
            fat_ratio: 0.2,
            protein_ratio: 2.0,
            activity_level: 0,
          },
        }

        post :create, params: params, as: :json

        first_name_error = build_validation_errors(
          "first_name", "blank"
        )
        activity_level_error = build_validation_errors(
          "activity_level", "too_big"
        )
        expect(response.code).to eql("422")
        expect(response.body).to include_json(first_name_error)
          .at_path("errors")
        expect(response.body).to include_json(activity_level_error)
          .at_path("errors")
      end
    end
  end

  def build_validation_errors(field, code)
    {
      "resource": "User",
      "field": field,
      "code": code,
    }.to_json
  end
end
