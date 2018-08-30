class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/user/show'
  end
  
  get '/signup' do
  	if !logged_in?
  		erb :'users/create_user'
  	else
  		redirect to '/tweets'
  	end
  end
  
  post '/signup' do
  	if logged_in?
  		redirect to '/tweets'
  	elsif params[:username] == "" || params[:email] == "" || params[:password] == ""
  		redirect to '/signup'
  	else 
  		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
  		session[:user_id] = @user.id
  		redirect to '/tweets'	
  	end
  end
  
  
end
