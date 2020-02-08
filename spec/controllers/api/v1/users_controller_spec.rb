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

        email_error = build_validation_errors("User", "email", "invalid")
        password_error = build_validation_errors(
          "User", "password", "too_short"
        )
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
          "User", "protein_ratio", "too_high"
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
          "User", "first_name", "blank"
        )
        activity_level_error = build_validation_errors(
          "User", "activity_level", "too_low"
        )
        expect(response.code).to eql("422")
        expect(response.body).to include_json(first_name_error)
          .at_path("errors")
        expect(response.body).to include_json(activity_level_error)
          .at_path("errors")
      end
    end
  end

  describe "#show" do
    it "requires authorization" do
      get :show, params: { id: "1" }, as: :json

      expect(response.code).to eql("401")
    end

    context "when current_user is the owner of resource" do
      it "responds with user info" do
        user = FactoryBot.create(:user)
        sign_in_user(user)
        expected_response = {
          id: user.id,
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name,
        }

        get :show, params: { id: user.id }, as: :json

        expect(response.code).to eql("200")
        expect(response.body).to eql(expected_response.to_json)
      end
    end

    context "when current_user is not the owner of the resource" do
      it "responds with forbidden status" do
        user = FactoryBot.create(:user)
        user1 = FactoryBot.create(:user)

        sign_in_user(user)

        get :show, params: { id: user1.id }, as: :json

        expect(response.code).to eql("403")
      end
    end

    context "when user is not present" do
      it "responds with not found status" do
        user = FactoryBot.create(:user, id: 1)

        sign_in_user(user)

        get :show, params: { id: 2 }, as: :json

        expect(response.code).to eql("404")
      end
    end
  end

  describe "#update" do
    it "requires authorization" do
      put :update, params: { id: "1" }, as: :json

      expect(response.code).to eql("401")
    end

    context "with valid params" do
      it "updates user" do
        user = FactoryBot.create(:user)
        params = {
          id: user.id,
          user: {
            email: "new_email@example.com",
            first_name: "John",
            last_name: "Doe",
            password: "new_password",
            password_confirmation: "new_password",
          },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        expected_response = {
          id: user.id,
          email: user.reload.email,
          first_name: user.reload.first_name,
          last_name: user.reload.last_name,
        }
        expect(response.code).to eql("200")
        expect(response.body).to be_json_eql(expected_response.to_json)
      end

      it "allows to update without providing password" do
        user = FactoryBot.create(:user)
        params = {
          id: user.id,
          user: {
            last_name: "New Last Name",
          },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        expected_response = {
          id: user.id,
          email: user.email,
          first_name: user.first_name,
          last_name: user.reload.last_name,
        }
        expect(response.code).to eql("200")
        expect(response.body).to be_json_eql(expected_response.to_json)
      end
    end

    context "with invalid params" do
      it "does not allow to change email for already registered one" do
        user = FactoryBot.create(:user)
        FactoryBot.create(:user, email: "already_taken_email@example.com")
        params = {
          id: user.id,
          user: { email: "already_taken_email@example.com" },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        email_error = build_validation_errors("User", "email", "taken")
        expect(response.code).to eql("422")
        expect(response.body).to include_json(email_error)
          .at_path("errors")
      end

      it "does not allow to change password for too short" do
        user = FactoryBot.create(:user)
        params = {
          id: user.id,
          user: { password: "pass", password_confirmation: "pass" },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        passsword_error = build_validation_errors(
          "User", "password", "too_short"
        )
        expect(response.code).to eql("422")
        expect(response.body).to include_json(passsword_error).at_path("errors")
      end
    end

    context "when current_user is not the owner of the resource" do
      it "responds with forbidden status" do
        user = FactoryBot.create(:user)
        user1 = FactoryBot.create(:user)

        sign_in_user(user)

        put :update, params: { id: user1.id }, as: :json

        expect(response.code).to eql("403")
      end
    end
  end
end
