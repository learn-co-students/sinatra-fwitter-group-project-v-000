require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sesson_secret, "secret"
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
    session[:id] = @user.id
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
      session[:id] = @user.id
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
    binding.pry
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
    @tweet.user_id = session[:id]
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
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect "/tweets"
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(@tweet.user_id)
      erb :'tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params["content"]
    @tweet.save
    redirect "/tweets/:id"
  end

end
