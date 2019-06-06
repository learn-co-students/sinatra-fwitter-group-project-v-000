class UsersController < ApplicationController

 get '/signup' do
   if session[:user_id]
     redirect :'/tweets'
   else
     erb :'/users/signup'
   end
 end

 post '/signup' do
   if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
     @user = User.create(params)
     session[:user_id] = @user.id
     redirect '/tweets'
   else
     redirect '/users/signup'
   end
 end

 get '/login' do
   if session[:user_id]
     redirect :'/tweets'
   else
     erb :'/users/login'
   end
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
