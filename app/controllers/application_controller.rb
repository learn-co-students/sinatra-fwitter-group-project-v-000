require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :index
    end
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    if @user.save
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    #binding.pry - this is not the route that the next test is on
    erb :'/users/show'
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params["content"])
    @tweet.user_id = session[:user_id]
    @tweet.save
    if @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(@tweet.user_id)
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @user = Helpers.current_user(session)
    @tweet = Tweet.find_by_id(params[:id])
    if @user.id == @tweet.user_id
      @tweet.delete
      redirect "/tweets"
    else
      redirect "/tweets"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @user = Helpers.current_user(session)
    if Helpers.logged_in?(session) && @user.id == @tweet.user_id
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params["content"]
    @tweet.save
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

end
