require "rails_helper"

describe ProfilePolicy do
  permissions :show? do
    it "grants access when profile belongs to user" do
      current_user = FactoryBot.build_stubbed(:user)
      profile = FactoryBot.build_stubbed(:profile, user: current_user)

      expect(described_class).to permit(
        current_user, Profile.new(id: profile.id)
      )
    end

    it "denies access when profile does not belong to user" do
      current_user = FactoryBot.build_stubbed(:user)
      FactoryBot.build_stubbed(:profile, id: 1, user: current_user)

      expect(described_class).not_to permit(current_user, Profile.new(id: 2))
    end
  end
end
