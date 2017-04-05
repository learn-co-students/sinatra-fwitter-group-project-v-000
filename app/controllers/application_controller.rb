require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if User.is_logged_in?(session)
      redirect ''
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  get '/logout' do
    if User.is_logged in?(session)
      session.clear
    end
    redirect '/'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end

  get '/tweets' do
    if User.is_logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
    end
    redirect '/tweets'
  end

  helpers do
    def self.is_logged_in?(session)
      !!session[:id]
    end

    def self.current_user(session)
      User.find(session[:id])
    end
  end

end
