# frozen_string_literal: true

module Api
  module V1
    # Registrations Controller
    class RegistrationsController < Devise::RegistrationsController
      before_action :ensure_params_exist, only: :create

      def create
        user = User.new user_params
        if user.save
          json_response('Siggned up successfully', true, { user: user }, :ok)
        else
          user.errors.map { |e| puts e }
          json_response('Somthing went wrong', false, {}, :unprocessable_entity)
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def ensure_params_exist
        return if params[:user].present?

        json_response('Missing params', false, {}, :bad_request)
      end
    end
  end
end
