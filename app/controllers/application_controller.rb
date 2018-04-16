require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      redirect :'tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect :'tweets'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      redirect :'tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    #binding.pry
    @user = User.find_by(username: params[:username])
    if !@user.nil?
    #  @tweets = Tweet.all
      session[:user_id] = @user.id

      redirect :'tweets'
    else
      erb :'users/signup'
    end
  end

  get '/tweets' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect :'users/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'tweets/create_tweet'
    else
      redirect :'users/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])
      #binding.pry
      erb :'tweets/show_tweet'
    else
      redirect :'/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweet = Tweet.find(params[:id])
      #binding.pry
      erb :'tweets/edit_tweet'
    else
      redirect :'users/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect :'tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect :"tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
    end
    #binding.pry
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    #binding.pry
    if @tweet.user == Helpers.current_user(session)
      @tweet.destroy
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      session.clear
      redirect :'users/login'
    else
      redirect :'/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    #binding.pry
    erb :'users/show'
  end

end
