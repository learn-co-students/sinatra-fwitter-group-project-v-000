class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    # if @user != nil && @user.password == params[:password]
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      
      redirect to'/tweets'
    else
      redirect to '/signup'
    end
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
  
end
