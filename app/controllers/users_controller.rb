class UsersController < ApplicationController

 get '/signup' do
   erb :'/users/new'
 end

 post '/signup' do
   @user = User.create(params)
   session[:user_id] = @user.id
   redirect '/tweets'
 end

 get '/login' do
   erb :'/users/login'
 end

 post '/login' do
   binding.pry
   @user = User.find_by_username(params[:username])
   session[:user_id] = @user.id
   redirect '/tweets'
 end
end
