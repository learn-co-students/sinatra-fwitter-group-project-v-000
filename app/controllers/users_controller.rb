
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      @user = get_user_by_session
      redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      login(@user)
      redirect to "/tweets/#{@user.slug}"
    else
      redirect to '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect to "/tweets"
    else
      redirect to '/login'
    end
  end

end
