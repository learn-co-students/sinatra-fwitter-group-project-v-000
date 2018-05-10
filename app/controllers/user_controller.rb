class UserController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/:slug' do
    if @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      erb :'/users/not_found'
    end
  end

end
