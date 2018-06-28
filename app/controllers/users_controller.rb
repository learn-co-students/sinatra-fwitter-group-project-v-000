class UsersController < ApplicationController

 get '/signup' do 
   
   erb :'/users/signup'
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
