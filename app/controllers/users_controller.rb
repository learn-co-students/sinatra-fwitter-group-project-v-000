class UsersController < ApplicationController

  get'/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'tweet/show_tweet'
  end

  # -- signup
  get "/signup" do
    if !session[:user_id]
      erb :"users/create_user"
    else
      redirect '/tweets'
    end
  end

  post "/signup" do

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create( username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get "/login" do
    if session[:user_id]
      redirect to :'tweets'
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end
