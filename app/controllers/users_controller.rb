class UsersController < ApplicationController
  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/users/:slug' do
    @user = User.find_by(:username => params[:slug])
    erb :'/users/show'
  end
end
