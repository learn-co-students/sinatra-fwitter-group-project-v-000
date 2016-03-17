require './config/environment'

class UsersController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end


  get '/signup' do
    if is_logged_in
      # erb :'/tweets/index'
      redirect to '/tweets'
    else
      erb :'users/create_user', layout: false
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.id.nil?
      redirect to '/signup'
    else
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if is_logged_in
      redirect to '/tweets'
    else
      erb :'users/login', layout: false
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if !@user
      redirect to '/login'
    end
    session[:id] = @user.id
    redirect to '/tweets'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    if !is_logged_in
      redirect to '/login'
    end
    @user = User.find_by_slug(params[:slug])
    if !@user
      redirect to '/'
    else
      @tweets = Tweet.where(user_id: @user.id)
      # @tweets = ["hello!", "Bollocks!"]
      erb :'/tweets/tweets'
    end
  end

end
