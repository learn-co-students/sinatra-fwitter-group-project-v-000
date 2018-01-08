require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if User.is_logged_in?(session)
      @user = User.current_user(session)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.new(params)
      if @user.save
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect 'signup'
      end
    end
  end

  get '/login' do
    if User.is_logged_in?(session)
      @user = User.current_user(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if params[:username].empty? || params[:password].empty?
      redirect '/login'
    else
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end
  end

  get '/logout' do
    if User.is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets' do
    if User.is_logged_in?(session)
      @user = User.current_user(session)
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if User.is_logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @user = User.current_user(session)
      @tweet = Tweet.create(content: params[:content], user_id: @user.id)
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user = User.current_user(session)
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{params[:id]}"
    end
  end

  delete '/tweets/:id/delete' do
    if User.is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == User.current_user(session)
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
