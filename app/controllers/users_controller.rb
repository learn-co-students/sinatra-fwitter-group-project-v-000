class UsersController < ApplicationController

  get '/users' do
    # How do I use the helper method?
    @user = User.find(session[:user_id])
    @tweets = Tweet.all
    erb :'/users/show'
  end

end
