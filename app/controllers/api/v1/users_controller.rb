module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate_user, except: [:create]

      def create
        @sign_up_form = SignUpForm.new(user_params.merge(profile_params))
        @sign_up_form.save
        respond_with @sign_up_form
      end

      private

      def user_params
        params.require(:user).permit(
          :email, :password, :password_confirmation, :first_name, :last_name
        )
      end

      def profile_params
        params.require(:profile).permit(
          :sex, :calorie_spread_ratio,
          :fat_ratio, :protein_ratio, :activity_level
        )
      end
    end
  end
end
