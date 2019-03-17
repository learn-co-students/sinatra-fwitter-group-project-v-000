class UsersController < ApplicationController

  get "/users/:slug" do
    user = User.find_by(params[:slug])
    @tweets = Tweet.find_all(user_id: user.id)
    erb :'/tweets/tweets'
  end


end
