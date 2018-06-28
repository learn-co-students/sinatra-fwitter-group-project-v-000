class UsersController < ApplicationController

 get '/signup' do 
   erb :'/users/signup'
 end
 
 post '/signup' do 
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:id] = @user.id 
   redirect to "/#{@user.id}"
 end
 
  get '/login' do 
    erb :'/users/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user && @user.authenticate(params["password"])
		  session[:user_id] = @user.id 
    else 
      erb :error
    end
  end
  
  get '/:id' do 
    @session = session
    @user = User.find(session[:id])
    @tweets = @user.tweets.all
    erb :'/users/show'
  end

end
