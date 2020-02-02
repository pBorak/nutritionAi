require "rails_helper"

describe UserPolicy do
  permissions :show? do
    it "grants access when user is the owner of resource" do
      current_user = FactoryBot.build_stubbed(:user, id: 1)

      expect(described_class).to permit(current_user, User.new(id: 1))
    end

    it "denies access when user is not the owner of resource" do
      current_user = FactoryBot.build_stubbed(:user, id: 1)

      expect(described_class).not_to permit(current_user, User.new(id: 2))
    end
  end
end
