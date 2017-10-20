class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
      erb :'users/signup'
  end

  post '/signup' do
    # if User.find_by(email: params[:email])
    #   flash[:message] = "This email address is already associated with an account.  Try logging in instead."
    #   redirect '/login'
    # end
    # if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    # binding.pry
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        flash[:message] = "All fields are required to create an account."
        redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      # && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  get '/logout' do
    login_check
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find(session[:user_id])
    erb :'/users/show'
  end

end
