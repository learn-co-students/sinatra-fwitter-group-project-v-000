require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # load the homepage
  get '/' do
    erb :index
  end
  
  # user sign up
  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  
  # user login
  get '/login' do
    if session[:user_id].nil?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  # user log out
  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
  
  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
  get '/tweets' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if session[:user_id].nil?
      redirect '/login'
    else
      @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
      if @tweet.save
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    end
  end
  
  # create tweet
  get '/tweets/new' do
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :'/tweets/create_tweet'
    else
      redirect :'/login'
    end
  end
  
  # show single tweet
  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end  
  
  # edit tweet
  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] && session[:user_id] == @tweet.user_id
      @tweet.content = params[:content]
      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    elsif session[:user_id] && session[:user_id] != @tweet.user_id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  # delete tweet
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] && session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect "/tweets"
    elsif session[:user_id] && session[:user_id] != @tweet.user_id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
end