class UsersController < ApplicationController

  get '/signup' do
    if !session[:id]
      erb :signup
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params.any? {|k, v| v.empty? }
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if !session[:id]
      erb :login
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user_page
  end
end