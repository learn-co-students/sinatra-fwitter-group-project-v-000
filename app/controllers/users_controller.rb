class UsersController < ApplicationController

  get '/users/:slug' do
    # How do I use the helper method?
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all
    erb :'/users/show'
  end

end
