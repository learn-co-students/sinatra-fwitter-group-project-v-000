class UserController < ApplicationController


  get '/signup' do
    if logged_in?
        redirect '/tweets'
    else 
        erb :"user/create_user"
    end
  end

  post '/signup' do
    @user = User.new(:username => params["username"], :password => params["password"], :email=>params["email"])
    if @user.save
        login(@user.email)
        redirect '/tweets'
    else
        redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
        redirect "/tweets"
    else
        erb :"user/login"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params["username"])
    if @user && @user.authenticate(params["password"])
        login(@user.email)
        redirect "/tweets"
    else
        redirect '/login'
    end   

  end

  get '/logout' do
    logout!
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params["slug"])
    @tweets = @user.tweets
    erb :'user/show'
  end


end