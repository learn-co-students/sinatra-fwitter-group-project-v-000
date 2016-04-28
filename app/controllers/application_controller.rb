require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get('/') {erb :homepage}
  get('/signup') {if logged_in?; redirect to "/tweets" else erb :signup end}
  get('/login') {erb :login}
  # post('login') {@user = User.find_by(params[:username]) ;erb :"/tweets/tweets"}
  get('/tweets/new') {erb :'/tweets/new'}
  post('/tweets') {erb :'/tweets/tweets'}
  get '/tweets' do 
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      erb :login
    end
  end

 post '/signup' do 
    @user = User.create(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets/tweets'
    else
      erb :login
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.all.find_by_id(params[:id])
    erb :"/tweets/edit"
  end

  post '/tweets/:id' do
    @tweet = Tweet.all.find_by_id(params[:id]) 
    erb :'/tweets/show'
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
      @user = User.find(session[:user_id])
      end
    end

    def login(user_id)
      session[:user_id] = user_id
    end

    def logout
      session.clear
    end
  end

end