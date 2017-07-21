require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "my_super_secret_session"
  end

  helpers do
    def current_user(session)
      @user = User.find(session[:id])
      @user
    end

    def is_logged_in?(session)
      !!session[:id] ? true : false
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if is_logged_in?(session)
      redirect 'tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect 'tweets'
    else
      redirect 'signup'
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect 'tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !!@user
      session[:id] = @user[:id]
      redirect 'tweets'
    else
      redirect 'login'
    end
  end

  get '/tweets' do
    if is_logged_in?(session)
      @user = current_user(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect 'login'
    end
  end

  post '/tweets' do
    if is_logged_in?(session)
      tweet = Tweet.new(content: params[:content], user_id: session[:id])
      if tweet.save
        redirect 'tweets'
      else
        redirect 'tweets/new'
      end
    else
      redirect 'login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'tweets/create_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session) # && session[:id] == @tweet.user_id
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect 'login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
    end
    redirect "/tweets/#{@tweet.id}"
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect 'login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if is_logged_in?(session) && session[:id] == @tweet.user_id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect 'login'
    end
  end

end
