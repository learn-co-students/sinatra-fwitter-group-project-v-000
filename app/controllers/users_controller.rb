class UsersController < ApplicationController

  get '/signup' do
    if current_user == nil
        erb :"users/create_user"
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    create_user(params)
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if !current_user
      erb :"users/login"
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    find_user(params)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect '/tweets'
    end
  end

  get '/logout' do
    if current_user
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets

    erb :"users/show"
  end




end
