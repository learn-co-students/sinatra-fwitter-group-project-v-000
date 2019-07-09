class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    end
    user = User.create(params)
    session[:user_id] = user.id
    redirect to "/tweets"
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/login'
    end  
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear      
    end
    redirect to "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/show'
  end

end