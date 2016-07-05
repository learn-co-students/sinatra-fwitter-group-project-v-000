class UsersController < ApplicationController

  get '/users/:slug' do
    erb :'/users/user_tweets'
  end

  get '/signup' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Error: Please fill in all the fields."
      redirect to '/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:message] = "It looks like you don't have an account yet. Sign up now to get started."
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