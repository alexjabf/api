# frozen_string_literal: true

module Api
  module V1
    # Sessions Controller
    class SessionsController < Devise::RegistrationsController
      before_action :sign_in_params, only: :create
      before_action :load_user, only: :create
      before_action :valid_token, only: :destroy
      skip_before_action :verify_signed_out_user, only: :destroy

      def create
        if @user.valid_password?(sign_in_params[:password])
          json_response('Siggned in successfully', true, { user: @user }, :ok)
        else
          json_response('Wrong credentials', false, {}, :unauthorized)
        end
      end

      def destroy
        sign_out @user
        @user.generate_new_authentication_token
        json_response('Siggned out successfully', true, { user: @user }, :ok)
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        @user || json_response('Wrong Credentias', false, {}, :unauthorized)
      end

      def valid_token
        @user = User.find_by(authentication_token: request.headers['AUTH-TOKEN'])
        @user || json_response('Invalid Token', false, {}, :unauthorized)
      end
    end
  end
end
