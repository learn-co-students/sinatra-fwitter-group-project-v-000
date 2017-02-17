require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'/home'
  end

  get '/signup' do
    if User.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if User.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets' do
    if User.is_logged_in?(session)
      erb :'/index'
    else
      redirect to '/login'
    end
  end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(params)
      @tweet.user_id = session[:id]
      @tweet.save
      erb :'/tweets/show_tweet'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if User.is_logged_in?(session) && Tweet.find_by_id(params[:id]).user_id == session[:id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      erb :'/tweets/show_tweet'
    else
      redirect to "/tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    if User.is_logged_in?(session) && Tweet.find_by_id(params[:id]).user_id == session[:id]
      Tweet.delete(params[:id])
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if User.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end