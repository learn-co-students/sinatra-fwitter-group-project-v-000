class UsersController < ApplicationController

  get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     @tweets = Tweet.all
     erb :'users/show'
  end

end
