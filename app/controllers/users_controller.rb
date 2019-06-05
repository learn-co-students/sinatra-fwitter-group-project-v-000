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
   @user = User.find_by(username: params[:username], password: params[:password])

   session[:user_id] = @user.id
   binding.pry
   redirect '/tweets'
 end
end
