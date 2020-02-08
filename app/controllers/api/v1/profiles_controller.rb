module Api
  module V1
    class ProfilesController < BaseController
      before_action :authenticate_user, only: %i[show update]

      def show
        @profile = Profile.find(params[:id])
        authorize @profile
        respond_with @profile
      end

      def update
        @profile = Profile.find(params[:id])
        authorize @profile
        @profile.update!(profile_params)
        respond_with @profile
      end

      private

      def profile_params
        params.require(:profile).permit(
          :sex, :calorie_spread_ratio,
          :fat_ratio, :protein_ratio, :activity_level
        )
      end
    end
  end
end
