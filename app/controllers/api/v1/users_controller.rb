# frozen_string_literal: true

module Api
  module V1
    # Users Controller
    class UsersController < ApplicationController
      def facebook
        if params[:facebook_access_token]
          graph = Koala::Facebook::API.new params[:facebook_access_token]
          user_data = graph.get_object('me?fields=name,email,id,picture')

          user = User.find_by email: user_data['email']
          sign_in_facebook_user(user, user_data)
        else
          json_response('Missing Facebook Token', false, {}, :unauthorized)
        end
      end

      def sign_in_facebook_user(user, user_data)
        if user
          user.generate_new_authentication_token
          return json_response('Siggned out successfully', true, { user: user }, :ok)
        end

        create_facebook_user(user_data)
      end

      def create_facebook_user(user_data)
        user = User.new(email: user_data['email'],
                        uid: user_data['uid'],
                        provider: 'facebook',
                        image: user_data['picture']['data']['url'],
                        password: Devise.friendly_token[0, 20])
        if user.save
          json_response('Siggned in with Facebook successfully', true, { user: user }, :ok)
        else
          json_response(user.errors, false, {}, :unauthorized)
        end
      end
    end
  end
end
