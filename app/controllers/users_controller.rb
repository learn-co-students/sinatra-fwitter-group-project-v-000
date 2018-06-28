class UsersController < ApplicationController

 get '/signup' do 
   erb :'/users/signup'
 end
 
 post '/signup' do 
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:id] = @user.id 
   redirect to "#{@user.username}"
 end
 
 
  get '/login' do 
    erb :'/users/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user 
      session[:user_id] = @user.id
      redirect "/#{@user.username}"
    else 
      erb :error
    end
  end


end
