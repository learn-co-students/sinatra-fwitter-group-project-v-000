require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create'
    end
  end

  post '/signup' do
    if !params['username'].empty? && !params['email'].empty? && !params['password'].empty?
      user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets' do
    if logged_in?(session)
      @tweets = Tweet.all
      @user = current_user(session)
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      @user = current_user(session)
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user(session).id)
      redirect to "tweets/#{@tweet.id}"
    else
      redirect 'tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      @user = current_user(session)
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user(session).id
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if !params["content"].empty?
      @tweet.update(content: params["content"])
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
    redirect "tweets/#{@tweet.id}"
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user(session).id
      @tweet.delete
    elsif !logged_in?(session)
      redirect '/login'
    end
    redirect '/tweets'
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
    end
    redirect to '/login'
  end



  helpers do
    def logged_in?(session)
      !!session[:user_id]
    end

    def current_user(session)
      User.find(session[:user_id])
    end
  end
end
