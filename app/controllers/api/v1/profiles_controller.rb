module Api
  module V1
    class ProfilesController < BaseController
      before_action :authenticate_user, only: %i[show]

      def show
        @profile = Profile.find(params[:id])
        authorize @profile
        respond_with @profile
      end
    end
  end
end
