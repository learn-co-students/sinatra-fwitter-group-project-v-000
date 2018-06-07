class UsersController < ApplicationController

  get '/users' do
    @users = User.all

    erb :'/users/index'
  end

  get '/users/new' do
    erb :'/figures/new'
  end

  post '/users' do
    #create new user
    @user = User.create(params["user"])

    redirect to "users/#{@user.id}"
  end

  get '/users/:id' do
    @user = User.find(params[:id])

    erb :'/users/show'
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])

    erb :'/users/edit'
  end

  post '/users/:id' do
    @user = User.find(params[:id])
    @user.update(params[:user])
    @user.save

    redirect to "/users/#{@user.id}"
  end

end
