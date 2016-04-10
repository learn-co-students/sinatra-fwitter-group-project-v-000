class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end   
  end

  post '/signup' do
    @user = User.new(params)

    if !@user.username.empty? && !@user.email.empty? && @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      # below would be better, but test does not allow
      # erb :'/users/signup', locals: {message: "Missing a required field."}
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      erb :'users/login', locals: {message: "Incorrect username and/or password."}
    end
  end

  get '/failure' do
    erb :'users/failure'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if !@user.nil?
      erb :'tweets/show_tweets'
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end
end