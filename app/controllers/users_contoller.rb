class UsersController < ApplicationController

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  post '/signup' do
    # binding.pry
    # may be check if user.save, then save session and redirect to tweets else flash message and redirect to signup
    if params[:username]=="" || params[:email]=="" || params[:password]==""
      flash[:message] = "Please fill all the field to sign in!!"
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    # binding.pry
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = "Invalid username and/or password!!"
      redirect '/login'
    end
  end

end
