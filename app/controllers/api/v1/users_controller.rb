class Api::V1::UsersController < ApplicationController

  def facebook
    if params[:facebook_access_token]
      graph = Koala::Facebook::API.new params[:facebook_access_token]
      user_data = graph.get_object("me?fields=name,email,id,picture")

      user = User.find_by email: user_data['email']
      if user
        user.generate_new_authentication_token
        json_response('Siggned out successfully', true, {user: user}, :ok)
      else
        p user_data
        user = User.new(email: user_data['email'],
                        uid: user_data['uid'],
                        provider: 'facebook',
                        image: user_data['picture']['data']['url'],
                        password: Devise.friendly_token[0, 20])
        if user.save
          json_response('Siggned in with Facebook successfully', true, {user: user}, :ok)
        else
          json_response(user.errors, false, {}, :unauthorized)
        end
      end
    else
      json_response('Missing Facebook Token', false, {}, :unauthorized)
    end
  end

end