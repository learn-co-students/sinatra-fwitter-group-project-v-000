class UsersController < ApplicationController

 get '/signup' do
   erb :'/users/new'
 end

 post '/signup' do
   if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
     @user = User.create(params)
     session[:user_id] = @user.id
     redirect '/tweets'
   else
     erb :'/'
   end
 end

 get '/login' do
   erb :'/users/login'
 end

 post '/login' do
   @user = User.find_by(username: params[:username], password: params[:password])

   session[:user_id] = @user.id
   redirect '/tweets'
 end

 get '/logout' do
   session.clear
   redirect '/'
 end
end
