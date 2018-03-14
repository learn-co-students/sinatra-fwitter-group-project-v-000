class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if (params[:username].empty? || params[:email].empty? || params[:password].empty?)
      redirect to '/signup'
    end
    @user = User.create(params)
    redirect to "/tweets"
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'/users/login'
  end

  post '/login' do
    if (params[:username].empty? || params[:password].empty?)
      redirect to '/login'
    end
    if @user = User.find_by(:username => params[:username]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
    else
      redirect to '/login'
    end
    redirect "/tweets"
  end

    get '/logout' do
      if logged_in?
        session.clear
        redirect to "/login"
      else
        redirect "/"
      end
    end


    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      @tweets = Tweet.where(user_id: @user.id)
      erb :'/users/show'
    end
end
