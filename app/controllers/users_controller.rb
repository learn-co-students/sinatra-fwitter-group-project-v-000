class UsersController < ApplicationController

 get '/signup' do
   erb :'/users/new'
 end

 post '/signup' do
   @user = User.new(params)

   if @user.save
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
   user = User.find_by(:username => params[:username])

   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect "/tweets"
   else
     redirect "/"
   end
 end

 get '/logout' do
   session.clear
   redirect '/'
 end
end
