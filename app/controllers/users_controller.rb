class UsersController < ApplicationController

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
  end
  
  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user', locals: {message: "Please sign up before you sign in"}
    else
     redirect to '/tweets'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.username != "" && @user.email != "" && @user.password != "" && @user.password != nil
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'users/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if is_logged_in? 
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end