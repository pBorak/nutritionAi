require "rails_helper"

RSpec.describe Api::V1::ProfilesController, type: :controller do
  describe "#show" do
    it "requires authorization" do
      get :show, params: { id: "1" }, as: :json

      expect(response.code).to eql("401")
    end

    context "when profile belongs to current_user" do
      it "responds with user's profile" do
        user = FactoryBot.create(:user, :with_profile)
        sign_in_user(user)
        expected_response = {
          id: user.id,
          sex: user.sex,
          calorie_spread_ratio: user.calorie_spread_ratio,
          fat_ratio: user.fat_ratio,
          protein_ratio: user.protein_ratio,
          activity_level: user.activity_level,
        }

        get :show, params: { id: user.profile.id }, as: :json

        expect(response.code).to eql("200")
        expect(response.body).to be_json_eql(expected_response.to_json)
      end
    end

    context "when profile does not belong to current_user" do
      it "responds with forbidden status" do
        user = FactoryBot.create(:user, :with_profile)
        user1 = FactoryBot.create(:user, :with_profile)

        sign_in_user(user)

        get :show, params: { id: user1.profile.id }, as: :json

        expect(response.code).to eql("403")
      end
    end

    context "when there are no user with this profile id" do
      it "responds with not found status" do
        user = FactoryBot.create(:user)

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
      it "updates profile" do
        user = FactoryBot.create(:user, :with_profile)
        params = {
          id: user.profile.id,
          profile: {
            calorie_spread_ratio: 0.3,
            fat_ratio: 0.4,
          },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        user.reload
        expected_response = {
          id: user.id,
          sex: user.sex,
          calorie_spread_ratio: user.calorie_spread_ratio,
          fat_ratio: user.fat_ratio,
          protein_ratio: user.protein_ratio,
          activity_level: user.activity_level,
        }
        expect(response.code).to eql("200")
        expect(response.body).to be_json_eql(expected_response.to_json)
      end
    end

    context "with invalid params" do
      it "does not allow to update activity level for zero" do
        user = FactoryBot.create(:user, :with_profile)
        params = {
          id: user.profile.id,
          profile: { activity_level: 0 },
        }
        sign_in_user(user)

        put :update, params: params, as: :json

        activity_error = build_validation_errors(
          "Profile", "activity_level", "too_low"
        )
        expect(response.code).to eql("422")
        expect(response.body).to include_json(activity_error)
          .at_path("errors")
      end
    end

    context "when user update not his profile" do
      it "responds with forbidden status" do
        user = FactoryBot.create(:user, :with_profile)
        user1 = FactoryBot.create(:user, :with_profile)

        sign_in_user(user)

        put :update, params: { id: user1.profile.id }, as: :json

        expect(response.code).to eql("403")
      end
    end
  end
end
