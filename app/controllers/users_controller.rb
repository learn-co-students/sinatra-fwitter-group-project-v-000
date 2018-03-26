class UsersController < ApplicationController
   get '/signup' do
      logged_in? ? (redirect '/tweets') : (erb :'users/create_user')
   end

   post '/signup' do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
         redirect '/signup'
      else
         session[:user_id] = User.create(username: params[:username], password: params[:password], email: params[:email]).id
         redirect '/tweets'
      end
   end

   get '/login' do
      logged_in? ? (redirect '/tweets') : (erb :'users/login')
   end

   post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect '/tweets'
      else
         redirect 'login'
      end
   end

   get '/logout' do
      session.clear
      redirect '/login'
   end

   get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
   end
end
