class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/create_user"
    end
  end
  
  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.username != "" && @user.email != "" && @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end
  
  get '/login' do
    erb :"users/login"
  end
  
  post '/login' do
    
    redirect "/users/#{@user.slug}"
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end
  
  get '/logout' do 
    @session.clear
  end
  
  get '/failure' do
    "failure"
  end
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
  end

end
