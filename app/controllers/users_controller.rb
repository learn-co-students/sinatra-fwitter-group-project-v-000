require 'pry'

class UsersController < ApplicationController

  get 'index' do
    erb :'/index'
  end

  get '/users/singnup' do
    erb :'users/signup'
  end

  post '/users' do
    @user = User.create(params[:user])
    @user.username = params[:username]
    @user.email = params [:email]
    @user.password = params[:password]
    @post.save
    redirect "/users/#{@user.id}"
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end




end
