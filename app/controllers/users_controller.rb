class UsersController < ApplicationController

  get '/signup' do

    if current_user
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do

    if !current_user
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do

    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
    end
    redirect "/tweets"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'users/show'

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
