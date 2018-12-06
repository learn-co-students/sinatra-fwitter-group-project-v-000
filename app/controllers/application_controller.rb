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
    if session[:user_id] == nil
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets' do
    #binding.pry
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if session[:user_id] == nil
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets/new' do
    if session[:user_id] != nil
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != ""
      @user = User.find(session[:user_id])
      @tweet = Tweet.new(content: params[:content])
      @user.tweets << @tweet
      @user.save
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if session[:user_id] != nil
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user.id == session[:user_id ]
      @tweet.destroy
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] != nil
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      if @tweet.user = @user
        erb :'/tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

end