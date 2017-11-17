class UserController < ApplicationController

  # users
    get '/signup' do
      if logged_in?
        redirect '/tweets'
      else
        erb :'users/create_user'
      end
    end

    post '/signup' do
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect '/tweets'
      else
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

    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect 'login'
      else
        redirect '/'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      if @user
        @tweets = @user.tweets
        erb :'users/show'
      else
        erb :'users/noshow'
      end
    end

end
