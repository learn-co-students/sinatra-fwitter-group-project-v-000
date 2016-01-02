class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/signup'
    end
  end

  post '/signup' do
    if invalid_signup?
      erb :'user/signup', locals: @error_message
    else
      @user = User.new(params[:data])
      @user.before_save
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'user/login'
    end
  end

  post '/login' do
    if missing_field?
      erb :'user/login', locals: {missing_field: "Please fill in both a username and a password."}
    else
      @user = User.find_by(username: params[:data][:username])
      if @user && @user.authenticate(params[:data][:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        erb :'user/login', locals: {invalid_login: "Invalid username or password."}
      end
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/users_tweets'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
