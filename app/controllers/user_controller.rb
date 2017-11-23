
class UserController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = Tweet.find_by(user_id: @user.id)
        erb :'/users/show'
    end
end
